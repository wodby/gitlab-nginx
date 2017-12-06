#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

gotpl /etc/gotpl/gitlab.conf.tpl > /etc/nginx/conf.d/gitlab.conf

if [[ -n "${GITLAB_PAGES_DOMAIN}" ]]; then
    export NGINX_PAGES_SERVER_NAME_REGEX="${GITLAB_PAGES_DOMAIN//./\\.}"
    gotpl /etc/gotpl/gitlab-pages.conf.tpl > /etc/nginx/conf.d/gitlab-pages.conf
fi
