# build arguments, defined in Makefile
ARG BASE_IMAGE_VERSION

FROM registry.cloudogu.com/official/base:${BASE_IMAGE_VERSION}
LABEL maintainer="hello@cloudogu.com"

ARG JAVA_ALPINE_VERSION

ENV \
  # default to utf-8 encoding
  LANG="C.UTF-8" \
  # java home
  JAVA_HOME="/usr/lib/jvm/java-8-openjdk" \
  # add java binaries to path
  PATH="$PATH:/usr/lib/jvm/java-8-openjdk/jre/bin:/usr/lib/jvm/java-8-openjdk/bin"

RUN set -x \
 && apk add --no-cache openjdk8="${JAVA_ALPINE_VERSION}"

COPY resources/ /
