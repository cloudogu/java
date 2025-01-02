ARG BASE_VER=3.21.0-1

FROM registry.cloudogu.com/official/base:${BASE_VER}
LABEL maintainer="hello@cloudogu.com"

# build arguments, passed from Makefile
ARG JAVA_ALPINE_VERSION

ENV \
  # default to utf-8 encoding
  LANG="C.UTF-8" \
  # java home
  JAVA_HOME="/usr/lib/jvm/java-21-openjdk" \
  # add java binaries to path
  PATH="$PATH:/usr/lib/jvm/java-21-openjdk/jre/bin:/usr/lib/jvm/java-21-openjdk/bin"

RUN set -x \
 # install java JAVA_ALPINE_VERSION is define in Makefile
 && apk add --no-cache openjdk21="${JAVA_ALPINE_VERSION}"

COPY resources/ /
