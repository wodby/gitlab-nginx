-include env_make

GITLAB_VER ?= 10.2.3
NGINX_VER ?= 1.13

GITLAB_MAJOR_VER ?= $(shell echo "${GITLAB_VER}" | grep -oE '^[0-9]+\.[0-9]+?')
TAG ?= $(GITLAB_MAJOR_VER)-$(NGINX_VER)

FROM_TAG = $(NGINX_VER)
REPO = wodby/wordpress-nginx
NAME = gitlab-$(GITLAB_VER)-nginx-$(NGINX_VER)

ifneq ($(FROM_STABILITY_TAG),)
    FROM_TAG := $(FROM_TAG)-$(FROM_STABILITY_TAG)
endif

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg FROM_TAG=$(FROM_TAG) --build-arg GITLAB_VER=$(GITLAB_VER) ./

test:
	IMAGE=$(REPO):$(TAG) ./test.sh

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

clean:
	-docker rm -f $(NAME)

release: build push
