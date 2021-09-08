#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

DIRECTORY="/etc/ssl"
STORE=""
STOREPASS="changeit"
CERTALIAS="ces"

function create(){
  # create ssl directory
  if [[ ! -d "$DIRECTORY" ]]; then
    mkdir "$DIRECTORY"
  fi

  # read certificate from etcd
  CERTIFICATE="$(mktemp)"
  doguctl config --global certificate/server.crt > "${CERTIFICATE}"

  cp "${JAVA_HOME}/jre/lib/security/cacerts" "${STORE}"
  # cacerts keystore is readonly in alpine package
  chmod 644 "${STORE}"
  keytool -keystore "${STORE}" -storepass "${STOREPASS}" -alias "${CERTALIAS}" \
    -import -file "${CERTIFICATE}" -noprompt

  # cleanup temp files
  rm -f "${CERTIFICATE}"
}

function run_main() {
  STORE="${1:-$DIRECTORY/truststore.jks}"
  create 2> /dev/null
  echo "-Djavax.net.ssl.trustStore=${STORE} -Djavax.net.ssl.trustStorePassword=${STOREPASS}"
}

# make the script only run when executed, not when sourced from bats tests)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  run_main "$@"
fi