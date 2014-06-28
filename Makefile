all: build

build:
	docker build -t deis/base .

shell:
	docker run -it --rm deis/base /bin/bash

clean:
	docker rmi deis/base
