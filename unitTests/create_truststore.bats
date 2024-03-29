#!/usr/bin/env bash
# Bind an unbound BATS variable that fails all tests when combined with 'set -o nounset'
export BATS_TEST_START_TIME="0"


load '/workspace/target/bats_libs/bats-support/load.bash'
load '/workspace/target/bats_libs/bats-assert/load.bash'
load '/workspace/target/bats_libs/bats-mock/load.bash'
load '/workspace/target/bats_libs/bats-file/load.bash'

setup() {
  export STARTUP_DIR=/workspace/

  # bats-mock/mock_create needs to be injected into the path so the production code will find the mock
  doguctl="$(mock_create)"
  export doguctl
  ln -s "${doguctl}" "${BATS_TMPDIR}/doguctl"
  keytool="$(mock_create)"
  export keytool
  export PATH="${PATH}:${BATS_TMPDIR}"
  ln -s "${keytool}" "${BATS_TMPDIR}/keytool"
  mockTruststore="$(mktemp)"
  export mockTruststore
  BATSLIB_FILE_PATH_REM="#${TEST_TEMP_DIR}"
  BATSLIB_FILE_PATH_ADD='<temp>'
}

teardown() {
  rm "${BATS_TMPDIR}/doguctl"
  rm "${BATS_TMPDIR}/keytool"
  rm "${mockTruststore}"
}

@test "running create_truststore.sh with store parameter should return a Java string with the correct truststore" {
  mock_set_status "${doguctl}" 0
  mock_set_output "${doguctl}" "-----BEGIN CERTIFICATE-----\nHELLO BASE CERTIFICATE\n-----END CERTIFICATE-----\n" 1
  export JAVA_HOME=/workspace/unitTests

  run /workspace/resources/usr/bin/create_truststore.sh "${mockTruststore}"

  assert_success
  assert_file_not_empty "${mockTruststore}"
  assert_line "-Djavax.net.ssl.trustStore=${mockTruststore} -Djavax.net.ssl.trustStorePassword=changeit"
  assert_equal "$(mock_get_call_num "${doguctl}")" "2"
  assert_equal "$(mock_get_call_args "${doguctl}" "1")" "config --global certificate/server.crt"
  assert_equal "$(mock_get_call_args "${doguctl}" "2")" "config --default NV --global certificate/additional/toc"
  assert_equal "$(mock_get_call_num "${keytool}")" "1"
  actualCall="$(mock_get_call_args "${keytool}" "1")"
  echo "$actualCall" | grep -E -- "-keystore ${mockTruststore} -storepass changeit -alias ces -import -file .* -noprompt"
}

@test "running create_truststore.sh with parameter should write certs to truststore a Java string with the correct truststore" {
  mock_set_status "${doguctl}" 0
  mock_set_output "${doguctl}" "-----BEGIN CERTIFICATE-----\nHELLO BASE CERTIFICATE\n-----END CERTIFICATE-----\n" 1
  mock_set_output "${doguctl}" "alias1 alias2\n" 2
  mock_set_output "${doguctl}" "alias1 alias2\n" 3
  mock_set_output "${doguctl}" "-----BEGIN CERTIFICATE-----\nCERT FOR CONTENT1\n-----END CERTIFICATE-----\n" 4
  mock_set_output "${doguctl}" "-----BEGIN CERTIFICATE-----\nCERT FOR CONTENT2\n-----END CERTIFICATE-----\n" 5
  mock_set_side_effect "${keytool}" "echo 'CERT FOR BASE' >> ${mockTruststore}" 1
  mock_set_side_effect "${keytool}" "echo 'CERT FOR CONTENT1' >> ${mockTruststore}" 2
  mock_set_side_effect "${keytool}" "echo 'CERT FOR CONTENT2' >> ${mockTruststore}" 3

  export BASE_CREATE_CERT_SKRIPT=/workspace/unitTests/usr/bin/create-ca-certificates.sh
  export JAVA_HOME=/workspace/unitTests

  run /workspace/resources/usr/bin/create_truststore.sh "${mockTruststore}"

  assert_success
  assert_file_not_empty "${mockTruststore}"
  assert_file_contains "${mockTruststore}" "CERT FOR BASE"
  assert_file_contains "${mockTruststore}" "CERT FOR CONTENT1"
  assert_file_contains "${mockTruststore}" "CERT FOR CONTENT2"
  assert_line "-Djavax.net.ssl.trustStore=${mockTruststore} -Djavax.net.ssl.trustStorePassword=changeit"
  assert_equal "$(mock_get_call_args "${doguctl}" "1")" "config --global certificate/server.crt"
  assert_equal "$(mock_get_call_args "${doguctl}" "2")" "config --default NV --global certificate/additional/toc"
  assert_equal "$(mock_get_call_args "${doguctl}" "3")" "config --global certificate/additional/toc"
  assert_equal "$(mock_get_call_args "${doguctl}" "4")" "config --global certificate/additional/alias1"
  assert_equal "$(mock_get_call_args "${doguctl}" "5")" "config --global certificate/additional/alias2"
  assert_equal "$(mock_get_call_num "${doguctl}")" "5"
  assert_equal "$(mock_get_call_num "${keytool}")" "3"
  actualCall="$(mock_get_call_args "${keytool}" "1")"
  echo "$actualCall" | grep -E -- "-keystore ${mockTruststore} -storepass changeit -alias ces -import -file .* -noprompt"
  actualCall="$(mock_get_call_args "${keytool}" "2")"
  echo "$actualCall" | grep -E -- "-keystore ${mockTruststore} -storepass changeit -alias alias1 -import -file .* -noprompt"
  actualCall="$(mock_get_call_args "${keytool}" "3")"
  echo "$actualCall" | grep -E -- "-keystore ${mockTruststore} -storepass changeit -alias alias2 -import -file .* -noprompt"
}

@test "importAdditionalCertificates() should do nothing on no additional certificates" {
  mock_set_status "${doguctl}" 0
  mock_set_output "${doguctl}" "" 1
  export JAVA_HOME=/workspace/unitTests

  source /workspace/unitTests/usr/bin/create-ca-certificates.sh
  source /workspace/resources/usr/bin/create_truststore.sh

  run importAdditionalCertificates

  assert_success
  assert_file_empty "${mockTruststore}"
  refute_output --regex ".*"
  assert_equal "$(mock_get_call_num "${doguctl}")" "1"
  assert_equal "$(mock_get_call_args "${doguctl}" "1")" "config --default NV --global certificate/additional/toc"
}


@test "importAdditionalCertificates() should add additional certificates" {
  mock_set_status "${doguctl}" 0
  mock_set_output "${doguctl}" "alias1 alias2\n" 1
  mock_set_output "${doguctl}" "alias1 alias2\n" 2
  mock_set_output "${doguctl}" "-----BEGIN CERTIFICATE-----\nCERT FOR CONTENT1\n-----END CERTIFICATE-----\n" 3
  mock_set_output "${doguctl}" "-----BEGIN CERTIFICATE-----\nCERT FOR CONTENT2\n-----END CERTIFICATE-----\n" 4
  mock_set_side_effect "${keytool}" "echo 'CERT FOR CONTENT1' >> ${mockTruststore}" 1
  mock_set_side_effect "${keytool}" "echo 'CERT FOR CONTENT2' >> ${mockTruststore}" 2

  source /workspace/unitTests/usr/bin/create-ca-certificates.sh
  source /workspace/resources/usr/bin/create_truststore.sh
  export STORE="${mockTruststore}"
  export JAVA_HOME=/workspace/unitTests

  run importAdditionalCertificates

  assert_success
  assert_file_not_empty "${mockTruststore}"
  assert_file_contains "${mockTruststore}" "CONTENT1"
  assert_file_contains "${mockTruststore}" "CONTENT2"
  refute_output --regex ".*"
  assert_equal "$(mock_get_call_num "${doguctl}")" "4"
  assert_equal "$(mock_get_call_args "${doguctl}" "1")" "config --default NV --global certificate/additional/toc"
  assert_equal "$(mock_get_call_args "${doguctl}" "2")" "config --global certificate/additional/toc"
  assert_equal "$(mock_get_call_args "${doguctl}" "3")" "config --global certificate/additional/alias1"
  assert_equal "$(mock_get_call_args "${doguctl}" "4")" "config --global certificate/additional/alias2"
  assert_equal "$(mock_get_call_num "${keytool}")" "2"
  actualCall1="$(mock_get_call_args "${keytool}" "1")"
  echo "$actualCall1" | grep -E -- "-keystore ${mockTruststore} -storepass changeit -alias alias1 -import -file .* -noprompt"
  actualCall2="$(mock_get_call_args "${keytool}" "2")"
  echo "$actualCall2" | grep -E -- "-keystore ${mockTruststore} -storepass changeit -alias alias2 -import -file .* -noprompt"
}
