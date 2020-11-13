JAVA_VERSION="8u252"
CHANGE_COUNTER="1"
JAVA_ALPINE_VERSION="8.252.09-r0"
IMAGE_NAME="registry.cloudogu.com/official/java"
IMAGE_TAG="$(JAVA_VERSION)-$(CHANGE_COUNTER)"

default: build

.PHONY: info
info:
	@echo "version informations ..."
	@echo "Java Version  : $(JAVA_VERSION)"
	@echo "Change Counter: $(CHANGE_COUNTER)"
	@echo "Apk Version   : $(JAVA_ALPINE_VERSION)"
	@echo "Image Name    : $(IMAGE_NAME)"
	@echo "Image Tag     : $(IMAGE_TAG)"
	@echo "Image         : $(IMAGE_NAME):$(IMAGE_TAG)"

.PHONY: build
build:
	docker build --build-arg JAVA_ALPINE_VERSION="$(JAVA_ALPINE_VERSION)" -t "$(IMAGE_NAME):$(IMAGE_TAG)" .

.PHONY: deploy
deploy: build
	docker push "$(IMAGE_NAME):$(IMAGE_TAG)"

.PHONY: shell
shell: build
	docker run --rm -ti "$(IMAGE_NAME):$(IMAGE_TAG)" bash || 0
