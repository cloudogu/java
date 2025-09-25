# build arguments, defined in Makefile
ARG BASE_IMAGE_VERSION
ARG JAVA_ALPINE_VERSION

FROM registry.cloudogu.com/official/base:${BASE_IMAGE_VERSION}
LABEL maintainer="hello@cloudogu.com"

ENV \
  # default to utf-8 encoding
  LANG="C.UTF-8" \
  # java home
  JAVA_HOME="/usr/lib/jvm/java-21-openjdk" \
  # add java binaries to path
  PATH="$PATH:/usr/lib/jvm/java-21-openjdk/jre/bin:/usr/lib/jvm/java-21-openjdk/bin"

RUN set -x \
 && apk add --no-cache openjdk21="${JAVA_ALPINE_VERSION}"

COPY resources/ /
