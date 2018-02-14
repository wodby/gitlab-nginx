#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

gitlab_ver=$1

url="https://gitlab.com/gitlab-org/gitlab-ce/raw/v${gitlab_ver}"

array=(
    "gitlab::${url}/lib/support/nginx/gitlab"
    "gitlab-pages::${url}/lib/support/nginx/gitlab-pages"
)

outdated=0

for index in "${array[@]}" ; do
    local="${index%%::*}"
    remote="${index##*::}"

    md5_local=$(cat "/orig/${local}" | md5sum)
    md5_remote=$(wget -qO- "${remote}" | md5sum)

    echo "Checking ${local}"

    if [[ "${md5_local}" != "${md5_remote}" ]]; then
        echo "!!! OUTDATED"
        echo "SEE ${remote}"
        outdated=1
    else
        echo "OK"
    fi
done

[[ "${outdated}" == 0 ]] || exit 1