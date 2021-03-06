REPO ?= dfherr/ruby
TAG  ?= 2.5.1

all: build push

clean:
	docker rmi $(shell docker images -q $(REPO))

build: Dockerfile
	docker build --rm -t $(REPO):$(TAG) .
	docker tag $(REPO):$(TAG) $(REPO):latest

push:
	docker push $(REPO):$(TAG)
	docker push $(REPO):latest
	git push
