IMAGE = $(USER)/git-svn
DOCKER_OPTS ?=

build:
	docker pull debian
	docker image build --tag $(IMAGE):latest .

build-alpine:
	docker pull alpine
	docker image build --file Dockerfile-alpine --tag $(IMAGE):alpine .

run:
	docker run -it --rm $(DOCKER_OPTS) $(IMAGE)

run-alpine:
	docker run -it --rm $(DOCKER_OPTS) $(IMAGE):alpine

rund:
	docker run --detach --rm $(DOCKER_OPTS) $(IMAGE)

rund-alpine:
	docker run --detach --rm $(DOCKER_OPTS) $(IMAGE):alpine

debug:
	docker run -it --rm --user root --mount 'type=bind,target=/usr/local/bin,source=$(PWD)' $(DOCKER_OPTS) $(IMAGE)

debug-alpine:
	docker run -it --rm --user root --mount 'type=bind,target=/usr/local/bin,source=$(PWD)' $(DOCKER_OPTS) $(IMAGE):alpine
