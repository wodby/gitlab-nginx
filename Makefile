-include env_make

GITLAB_VER ?= 10.4.3
NGINX_VER ?= 1.13

GITLAB_MAJOR_VER ?= $(shell echo "${GITLAB_VER}" | grep -oE '^[0-9]+')
TAG ?= $(GITLAB_MAJOR_VER)-$(NGINX_VER)

BASE_IMAGE_TAG = $(NGINX_VER)
REPO = wodby/gitlab-nginx
NAME = gitlab-$(GITLAB_VER)-nginx-$(NGINX_VER)

ifneq ($(BASE_IMAGE_STABILITY_TAG),)
    BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)-$(BASE_IMAGE_STABILITY_TAG)
endif

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) --build-arg GITLAB_VER=$(GITLAB_VER) ./

test:
	GITLAB_MAJOR_VER=$(GITLAB_MAJOR_VER) IMAGE=$(REPO):$(TAG) ./test.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

compare-orig-configs:
	docker run --rm \
		-v $(PWD)/compare-orig-configs.sh:/usr/local/bin/compare-orig-configs.sh \
		-v $(PWD)/orig:/orig \
		wodby/alpine compare-orig-configs.sh $(GITLAB_VER)

clean:
	-docker rm -f $(NAME)

release: build push
