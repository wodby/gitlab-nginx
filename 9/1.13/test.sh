#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

nginxExec() {
    docker-compose -f test/docker-compose.yml exec --user=82 nginx "${@}"
}

docker-compose -f test/docker-compose.yml up -d

nginxExec make check-ready -f /usr/local/bin/actions.mk

docker-compose -f test/docker-compose.yml down