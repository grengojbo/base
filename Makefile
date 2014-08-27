IMAGE=grengojbo/base
IMAGE_NAME=base

all: build

build:
	#docker build -t tmpimg .
	docker run -it --name base_img tmpimg /bin/bash

shell:
	docker run -it --rm ${IMAGE} /bin/bash

clean:
	docker rmi ${IMAGE}

push:
	#docker export ${shell docker ps -a | grep 'base_img' | awk '{print $$1}'} | docker import - ${IMAGE}:latest
	#docker rm ${shell docker ps -a | grep 'base_img' | awk '{print $$1}'}
	#docker rmi tmpimg
	docker push ${IMAGE}

pull:
	@docker pull ${IMAGE}

.PHONY: all clean shell build push pull
