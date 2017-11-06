# Nginx for Gitlab Docker Container Image 

[![Build Status](https://travis-ci.org/wodby/gitlab-nginx.svg?branch=master)](https://travis-ci.org/wodby/gitlab-nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/gitlab-nginx.svg)](https://hub.docker.com/r/wodby/gitlab-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/gitlab-nginx.svg)](https://hub.docker.com/r/wodby/gitlab-nginx)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

* All images are based on Alpine Linux
* Base image: [wodby/nginx](https://github.com/wodby/nginx)
* [Travis CI builds](https://travis-ci.org/wodby/gitlab-nginx) 
* [Docker Hub](https://hub.docker.com/r/wodby/gitlab-nginx)

For better reliability we release images with stability tags (`wodby/gitlab-nginx:1.13-X.X.X`) which correspond to git tags. We **strongly recommend** using images only with stability tags. Below listed basic tags:

| Image tag (Dockerfile)                                                        | Nginx   |
| ----------------------------------------------------------------------------- | ------- |
| [1.13 (latest)](https://github.com/wodby/gitlab-nginx/tree/master/Dockerfile) | 1.13.6  |

## Environment Variables

See more at [wodby/nginx](https://github.com/wodby/nginx)

| Variable                       | Default Value       | Description |
| ------------------------------ | ------------------- | ----------- |
| NGINX_WORKHORSE_HOST           | workhorse:8181      |             |
| NGINX_SERVER_NAME              | default             |             |
| NGINX_GITLAB_PAGES_DOMAIN      |                     |             |
| NGINX_GITLAB_PAGES_HOST        | http://pages:8090/  |             |

## Orchestration actions

See more at [wodby/nginx](https://github.com/wodby/nginx)

## Deployment

Deploy GitLab to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
