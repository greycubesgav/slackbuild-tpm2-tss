DOCKER_USER=greycubesgav
DOCKER_IMAGE_NAME=slackware-tpm2-tss
DOCKER_IMAGE_VERSION=latest
DOCKER_PLATFORM=linux/amd64

docker-image-build:
	docker build --platform $(DOCKER_PLATFORM) --file Dockerfile --tag $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) .

docker-image-run:
	docker run --platform $(DOCKER_PLATFORM) --rm -it $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

docker-artifact-build:
	DOCKER_BUILDKIT=1 docker build --platform $(DOCKER_PLATFORM) --file Dockerfile --tag $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) --target artifact --output type=local,dest=./pkgs/ .
