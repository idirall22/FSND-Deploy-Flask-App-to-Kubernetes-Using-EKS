PROJECT_ID=$(shell gcloud config get-value project)

freeze:
	pip3 freeze > requirements.txt

install:
	pip3 install -r requirements.txt

env:
	virtualenv env

build:
	docker build -t simple-jwt-api .

run:
	docker run -p 8080:8080 --env-file=.env_file --name simple-jwt-api simple-jwt-api

remove:
	docker rm -f deploy

artifacts:
	gcloud artifacts repositories list
	# gcloud artifacts repositories create jwt-api --repository-format=docker \
    # --location=europe-west1 --description="Docker jwt-api repository"

deploy:
	# @echo $(PROJECT_ID)
	gcloud builds submit \
	--tag europe-west1-docker.pkg.dev/$(PROJECT_ID)/simple-jwt-api/deploy:v1
	
