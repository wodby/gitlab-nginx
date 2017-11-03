#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

compose() {
    docker-compose -f test/docker-compose.yml "${@}"
}

compose up -d
compose exec nginx make check-ready -f /usr/local/bin/actions.mk
compose down
