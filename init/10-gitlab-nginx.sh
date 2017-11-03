#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

sudo fix-permissions.sh git git "${NGINX_GITLAB_DATA_DIR}" "${NGINX_GITLAB_PUBLIC_FILES_DIR}"

gotpl /etc/gotpl/gitlab.conf.tpl > /etc/nginx/conf.d/gitlab.conf

if [[ -n "${NGINX_GITLAB_PAGES_DOMAIN}" ]]; then
    export NGINX_PAGES_SERVER_NAME_REGEX="${NGINX_GITLAB_PAGES_DOMAIN//./\\.}"
    gotpl /etc/gotpl/gitlab-pages.conf.tpl > /etc/nginx/conf.d/gitlab-pages.conf
fi
