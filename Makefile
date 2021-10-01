all: build

build:
	docker build -t ubuntu:20.04 .

run:
	docker run -it ubuntu:20.04

deploy:
	docker push ubuntu:20.04
