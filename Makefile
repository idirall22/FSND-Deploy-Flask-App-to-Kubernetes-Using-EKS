PROJECT_ID=$(shell gcloud config get-value project)
DOCKER_IMAGE=idirall22/simple-jwt-api

freeze:
	pip3 freeze > requirements.txt

install:
	pip3 install -r requirements.txt

env:
	virtualenv env

build:
	docker build -t $(DOCKER_IMAGE) .

run:
	python3 main.py

remove:
	docker rm -f deploy

dockerhub:
	docker push $(DOCKER_IMAGE)