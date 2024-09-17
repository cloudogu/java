ARG BASE_VER=3.20.3-1

FROM registry.cloudogu.com/official/base:${BASE_VER}
LABEL maintainer="hello@cloudogu.com"

# build arguments, passed from Makefile
ARG JAVA_ALPINE_VERSION

# environment variables
ENV \
  # default to utf-8 encoding
  LANG="C.UTF-8" \
  # java home
  JAVA_HOME="/usr/lib/jvm/java-11-openjdk" \
  # add java binaries to path
  PATH="$PATH:/usr/lib/jvm/java-11-openjdk/jre/bin:/usr/lib/jvm/java-11-openjdk/bin"

RUN set -x \
 # install java JAVA_ALPINE_VERSION is define in Makefile
 && apk update && apk upgrade \
 && apk add --no-cache openjdk11="${JAVA_ALPINE_VERSION}"

# copy resources
COPY resources/ /
