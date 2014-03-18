all: build

build:
	docker build -t deis/base .

shell:
	docker run -t -i deis/base /bin/bash

clean:
	docker rmi deis/base
