PROJECT_ID=$(shell gcloud config get-value project)
DOCKER_IMAGE=simple-jwt-api

freeze:
	pip3 freeze > requirements.txt

install:
	pip3 install -r requirements.txt

env:
	virtualenv env

build:
	docker build -t $(DOCKER_IMAGE) .

pull:
	docker pull europe-west1-docker.pkg.dev/gateway-282214/simple-jwt-api/simple-jwt-api
	
run:
	python3 main.py
	# gcloud artifacts docker images list europe-west1-docker.pkg.dev/gateway-282214/simple-jwt-api/simple-jwt-api
	# docker run \
	# -p 8080:8080 \
	# --name $(DOCKER_IMAGE) \
	# europe-west1-docker.pkg.dev/$(PROJECT_ID)/$(DOCKER_IMAGE)/$(DOCKER_IMAGE)
	# --env-file=.env_file \

remove:
	docker rm -f deploy

artifacts:
	# gcloud artifacts repositories list
	gcloud artifacts repositories create $(DOCKER_IMAGE) \
	--repository-format=docker \
    --location=europe-west1 \
	--description="Docker udacity $(DOCKER_IMAGE) repository"

deploy:
	gcloud builds submit \
	--tag europe-west1-docker.pkg.dev/$(PROJECT_ID)/$(DOCKER_IMAGE)/$(DOCKER_IMAGE)
	
dockerhub: build
	docker push $(DOCKER_IMAGE)