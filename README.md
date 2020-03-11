[![GitHub license](https://img.shields.io/github/license/cloudogu/java.svg)](https://github.com/cloudogu/java/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/cloudogu/java.svg)](https://github.com/cloudogu/java/releases)

# dogu java docker image

official/java is based on official/base, thus inheriting doguctl, bash and other tools.

## how to build

    docker build -t official/java:<java major version>u<java minor/update version>-<cloudogu revision> .

example

    docker build -t official/java:8u242-1 .


NOTE: _java major version_ and _java minor/update version_ see ENV statement in Dockerfile

NOTE: _java major version_, _java minor/update version_ and _cloudogu revision_ should be mentioned on the first line in Dockerfile

