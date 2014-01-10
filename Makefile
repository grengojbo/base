all: build

build:
	docker build -t deis/base .

shell:
	./make.sh run -t -i -rm deis/base /bin/bash

clean:
	docker rmi deis/base
