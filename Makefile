#!make
include ../.env
export

IMAGE = radshift-mongodb
TAG = latest

default: deploy

build:
	docker build -t $(REPO)/$(IMAGE) .

run: build
	docker run $(REPO)/$(IMAGE)

deploy: build
	docker tag $(REPO)/$(IMAGE) $(REPO)/$(IMAGE):$(TAG)
	docker push $(REPO)/$(IMAGE):$(TAG)