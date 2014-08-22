all: build

build:
	docker build -t grengojbo/base .

shell:
	docker run -it --rm grengojbo/base /bin/bash

clean:
	docker rmi grengojbo/base
