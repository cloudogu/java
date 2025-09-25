JAVA_VERSION=21.0.5
CHANGE_COUNTER=1
BASE_IMAGE_VERSION=3.21.0-1
JAVA_ALPINE_VERSION=21.0.5_p11-r0
IMAGE_NAME=registry.cloudogu.com/official/java
IMAGE_NAME_PRERELEASE=registry.cloudogu.com/prerelease_official/java
IMAGE_TAG=$(JAVA_VERSION)-$(CHANGE_COUNTER)
MAKEFILES_VERSION=10.3.0

include build/make/variables.mk
include build/make/self-update.mk
include build/make/clean.mk
include build/make/bats.mk

TESTS_DIR=./unitTests

default: build

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
