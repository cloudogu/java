# Container building

This container image provides the base of many dogu container images.

## Instructions for building and deploying

On a development branch:

1. Update the `Makefile` fields `JAVA_VERSION`, `JAVA_ALPINE_VERSION` and `CHANGE_COUNTER` accordingly
2. PR/merge the development branch into the target-branch
3. Tag the target commit (e.g. `v3.45.6-7`) for the release.

The following parameters are available in the Jenkins Pipeline:
- `PublishRelease`
- `PublishPrerelease`

If these parameters are enabled, the image will be published after successful build.

With the `PublishPrerelease` parameter enabled, the image will be published in the namespace `registry.cloudogu.com/prerelease_official/`.

With the `PublishRelease` parameter enabled, the image will be published in the namespace `registry.cloudogu.com/official/` and a GitHub Release will be created.

To rebuild and publish older versions of the image, branches are available for which the build and release process can be started using parameters similar to the main branch.
