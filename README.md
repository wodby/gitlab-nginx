# Nginx for Gitlab Docker Container Image 

[![Build Status](https://travis-ci.org/wodby/gitlab-nginx.svg?branch=master)](https://travis-ci.org/wodby/gitlab-nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/gitlab-nginx.svg)](https://hub.docker.com/r/wodby/gitlab-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/gitlab-nginx.svg)](https://hub.docker.com/r/wodby/gitlab-nginx)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/gitlab-nginx.svg)](https://microbadger.com/images/wodby/gitlab-nginx)

## Docker Images

!!! For better reliability we release images with stability tags (`wodby/gitlab-nginx:10-1.13-X.X.X`) which correspond to [git tags](https://github.com/wodby/gitlab-nginx/releases). We **STRONGLY RECOMMEND** using images only with stability tags. 

Overview:

* All images are based on Alpine Linux
* Base image: [wodby/nginx](https://github.com/wodby/nginx)
* [Travis CI builds](https://travis-ci.org/wodby/gitlab-nginx) 
* [Docker Hub](https://hub.docker.com/r/wodby/gitlab-nginx)

Supported tags and respective `Dockerfile` links:

* `10-1.13`, `latest` [_(Dockerfile)_](https://github.com/wodby/gitlab-nginx/tree/master/Dockerfile)

## Environment Variables

| Variable               | Default Value       | Description |
| ---------------------- | ------------------- | ----------- |
| `NGINX_WORKHORSE_HOST` | `workhorse:8181`    |             |
| `NGINX_SERVER_NAME`    | `default`           |             |
| `GITLAB_PAGES_DOMAIN`  |                     |             |
| `GITLAB_PAGES_URL`     |                     |             |
| `GITLAB_HTTPS`         |                     |             |

See [wodby/nginx](https://github.com/wodby/nginx) for all variables.

## Orchestration actions

See [wodby/nginx](https://github.com/wodby/nginx) for all actions.

## Deployment

Deploy GitLab to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
