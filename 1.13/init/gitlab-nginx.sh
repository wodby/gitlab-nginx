#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

gotpl /etc/gotpl/gitlab.conf.tpl > /etc/nginx/conf.d/gitlab.conf
