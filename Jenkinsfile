#!groovy
@Library(['github.com/cloudogu/ces-build-lib@6.1.0', 'github.com/cloudogu/dogu-build-lib@v4.2.0'])
import com.cloudogu.ces.cesbuildlib.*
import com.cloudogu.ces.dogubuildlib.*
import org.jenkinsci.plugins.pipeline.modeldefinition.Utils

timestamps {
    node('cpu2mem4') {

        properties([
                // Keep only the last x builds to preserve space
                buildDiscarder(logRotator(numToKeepStr: '10')),
                // Don't run concurrent builds for a branch, because they use the same workspace directory
                disableConcurrentBuilds(),
                parameters([
                        booleanParam(name: 'PublishRelease', description: 'Publish a RELEASE image to the registry.', defaultValue: false),
                        booleanParam(name: 'PublishPrerelease', description: 'Publish a prerelease image to the registry.', defaultValue: false),
                        choice(name: 'TrivySeverityLevels', choices: [TrivySeverityLevel.CRITICAL, TrivySeverityLevel.HIGH_AND_ABOVE, TrivySeverityLevel.MEDIUM_AND_ABOVE, TrivySeverityLevel.ALL], description: 'The levels to scan with trivy', defaultValue: TrivySeverityLevel.CRITICAL),
                        choice(name: 'TrivyStrategy', choices: [TrivyScanStrategy.UNSTABLE, TrivyScanStrategy.FAIL, TrivyScanStrategy.IGNORE], description: 'Define whether the build should be unstable, fail or whether the error should be ignored if any vulnerability was found.', defaultValue: TrivyScanStrategy.UNSTABLE),
                ])
        ])

        Git git = new Git(this, "cesmarvin")
        GitHub github = new GitHub(this, git)
        Changelog changelog = new Changelog(this)

        stage('Checkout') {
            checkout scm
        }

        final String javaVersion = sh(returnStdout: true, script: 'awk -F\'=\' \'/^JAVA_VERSION=/{gsub(/"/, "", $2); print $2}\' Makefile').trim()
        final String changeCounter = sh(returnStdout: true, script: 'awk -F\'=\' \'/^CHANGE_COUNTER=/{gsub(/"/, "", $2); print $2}\' Makefile').trim()

        final String imageName = sh(returnStdout: true, script: 'awk -F\'=\' \'/^IMAGE_NAME=/{gsub(/"/, "", $2); print $2}\' Makefile').trim()
        final String imageVersion = "${javaVersion}-${changeCounter}"

        stage('Lint') {
            lintDockerfile()
            final String scriptFiles = sh(returnStdout: true, script: "find resources -iname '*.sh' | xargs").trim()
            shellCheck(scriptFiles)
        }

        stage('Build') {
            withCredentials([[$class          : 'UsernamePasswordMultiBinding',
                              credentialsId   : "cesmarvin-setup",
                              usernameVariable: 'TOKEN_ID',
                              passwordVariable: 'TOKEN_SECRET']]) {
                sh "docker login -u ${escapeToken(env.TOKEN_ID)} -p ${escapeToken(env.TOKEN_SECRET)} registry.cloudogu.com"
                sh "make build"
                sh "docker logout registry.cloudogu.com"
            }
        }

        stage('Test') {
            sh "make unit-test-shell-local"
        }

        stage('Trivy scan') {
            Trivy trivy = new Trivy(this)
            trivy.scanImage("${imageName}:${imageVersion}", params.TrivySeverityLevels, params.TrivyStrategy)
            trivy.saveFormattedTrivyReport(TrivyScanFormat.TABLE)
            trivy.saveFormattedTrivyReport(TrivyScanFormat.JSON)
            trivy.saveFormattedTrivyReport(TrivyScanFormat.HTML)
        }

        stage('Publish prerelease') {
            if (!params.PublishPrerelease) {
                Utils.markStageSkippedForConditional(STAGE_NAME)
                return
            }
            withCredentials([[$class          : 'UsernamePasswordMultiBinding',
                              credentialsId   : "harborrobotprerelease",
                              usernameVariable: 'TOKEN_ID',
                              passwordVariable: 'TOKEN_SECRET']]) {
                sh "docker login -u ${escapeToken(env.TOKEN_ID)} -p ${escapeToken(env.TOKEN_SECRET)} registry.cloudogu.com"
                sh "make deploy-prerelease"
                sh "docker logout registry.cloudogu.com"
            }
        }

        final String currentTag = sh(returnStdout: true, script: "git tag --points-at HEAD").trim()
        final String currentBranch = sh(returnStdout: true, script: "git branch --show-current").trim()
        stage('Validate tag') {
            if (!params.PublishRelease) {
                Utils.markStageSkippedForConditional(STAGE_NAME)
                return
            }
            if (!git.originTagExists(currentTag)) {
                println("Creating missing tag: ${imageVersion}")
                git.setTag(imageVersion, "Release ${imageVersion}", 'sos-automat', 'sos@cloudogu.com')
                git.push(imageVersion)
            }
        }
        stage('Publish release') {
            if (!params.PublishRelease) {
                Utils.markStageSkippedForConditional(STAGE_NAME)
                return
            }
            println("Publishing release at tag: ${currentTag}")
            withCredentials([[$class          : 'UsernamePasswordMultiBinding',
                              credentialsId   : "cesmarvin-setup",
                              usernameVariable: 'TOKEN_ID',
                              passwordVariable: 'TOKEN_SECRET']]) {
                sh "docker login -u ${escapeToken(env.TOKEN_ID)} -p ${escapeToken(env.TOKEN_SECRET)} registry.cloudogu.com"
                sh "make deploy"
                sh "docker logout registry.cloudogu.com"
            }
            // createReleaseWithChangelog takes only the changelog. Build the body here to put the image path on top.
            // changesForVersion returns JSON-escaped text, so newlines are written as \\n here as well.
            try {
                String body = "```\\n${imageName}:${imageVersion}\\n```\\n\\n" + changelog.changesForVersion(imageVersion)
                github.createRelease(imageVersion, body, currentBranch)
            } catch (IllegalArgumentException e) {
                unstable("Release failed due to error: ${e}")
                echo 'Please manually update github release.'
            }
        }
        stage('Notify Webhook') {
            if (!params.PublishRelease) {
                Utils.markStageSkippedForConditional(STAGE_NAME)
                return
            }
            new Webhook(this).notifyRelease(name: 'base-java', version: imageVersion)
        }

    }
}

static def escapeToken(String token) {
    token = token.replaceAll("\\\$", '\\\\\\\$')
    return token
}
