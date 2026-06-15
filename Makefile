JAVA_VERSION=8.482.08
CHANGE_COUNTER=1
BASE_IMAGE_VERSION=3.24.0-1
JAVA_ALPINE_VERSION=8.482.08-r0
IMAGE_NAME=registry.cloudogu.com/official/java
IMAGE_NAME_PRERELEASE=registry.cloudogu.com/prerelease_official/java
IMAGE_TAG=$(JAVA_VERSION)-$(CHANGE_COUNTER)
# renovate: datasource=github-tags depName=cloudogu/makefiles extractVersion=^v(?<version>.*)$
MAKEFILES_VERSION=10.9.1

default: build

include build/make/variables.mk
include build/make/self-update.mk
include build/make/clean.mk
include build/make/bats.mk

TESTS_DIR=./unitTests

.PHONY: info
info:
	@echo "version information ..."
	@echo "Java version       : $(JAVA_VERSION)"
	@echo "Package version    : $(JAVA_ALPINE_VERSION)"
	@echo "Base Image version : $(BASE_IMAGE_VERSION)"
	@echo "Image (release)    : $(IMAGE_NAME):$(IMAGE_TAG)"
	@echo "Image (prerelease) : $(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"

.PHONY: build
build:
	docker build \
		--build-arg "BASE_IMAGE_VERSION=$(BASE_IMAGE_VERSION)" \
		--build-arg "JAVA_ALPINE_VERSION=$(JAVA_ALPINE_VERSION)" \
	-t "$(IMAGE_NAME):$(IMAGE_TAG)" .

.PHONY: deploy
deploy: build
	@echo "Publishing image $(IMAGE_NAME):$(IMAGE_TAG)"
	docker push "$(IMAGE_NAME):$(IMAGE_TAG)"

.PHONY: deploy-prerelease
deploy-prerelease: build
	@echo "Publishing image $(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"
	docker tag "$(IMAGE_NAME):$(IMAGE_TAG)" "$(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"
	docker rmi "$(IMAGE_NAME):$(IMAGE_TAG)"
	docker push "$(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"

.PHONY: shell
shell: build
	docker run --rm -ti "$(IMAGE_NAME):$(IMAGE_TAG)" bash || 0

.PHONY unit-test-shell:
unit-test-shell: unit-test-shell-$(ENVIRONMENT)

$(BATS_ASSERT):
	@git clone --depth 1 https://github.com/bats-core/bats-assert $@

$(BATS_MOCK):
	@git clone --depth 1 https://github.com/grayhemp/bats-mock $@

$(BATS_SUPPORT):
	@git clone --depth 1 https://github.com/bats-core/bats-support $@

$(BATS_FILE):
	@git clone --depth 1 https://github.com/bats-core/bats-file $@

$(BASH_SRC):
	BASH_SRC:=$(shell find "${WORKDIR}" -type f -name "*.sh")

${BASH_TEST_REPORT_DIR}: $(TARGET_DIR)
	@mkdir -p $(BASH_TEST_REPORT_DIR)

unit-test-shell-ci: $(BASH_SRC) $(BASH_TEST_REPORT_DIR) $(BATS_ASSERT) $(BATS_MOCK) $(BATS_SUPPORT) $(BATS_FILE)
	@echo "Test shell units on CI server"
	@make unit-test-shell-generic

unit-test-shell-local: $(BASH_SRC) $(PASSWD) $(ETCGROUP) $(HOME_DIR) buildTestImage $(BASH_TEST_REPORT_DIR) $(BATS_ASSERT) $(BATS_MOCK) $(BATS_SUPPORT) $(BATS_FILE)
	@echo "Test shell units locally (in Docker)"
	@docker run --rm \
		-v $(HOME_DIR):/home/$(USER) \
		-v $(WORKDIR):$(WORKSPACE) \
		-w $(WORKSPACE) \
		--entrypoint="" \
		$(BATS_CUSTOM_IMAGE):$(BATS_TAG) \
		${TESTS_DIR}/customBatsEntrypoint.sh make unit-test-shell-generic

unit-test-shell-generic:
	@bats --formatter junit --output ${BASH_TEST_REPORT_DIR} ${TESTS_DIR}

.PHONY buildTestImage:
buildTestImage:
	@echo "Build shell test container"
	@cd ${TESTS_DIR} && docker build \
		--build-arg=BATS_BASE_IMAGE=${BATS_BASE_IMAGE} \
		--build-arg=BATS_TAG=${BATS_TAG} \
		-t ${BATS_CUSTOM_IMAGE}:${BATS_TAG} \
		.
