ARG BASE_IMAGE_TAG

FROM wodby/nginx:${BASE_IMAGE_TAG}

ARG GITLAB_VER

ENV GITLAB_VER="${GITLAB_VER}"

ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/v${GITLAB_VER}/public/404.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/v${GITLAB_VER}/public/422.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/v${GITLAB_VER}/public/500.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/v${GITLAB_VER}/public/502.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/v${GITLAB_VER}/public/503.html /etc/nginx/gitlab/

COPY templates/gitlab.conf.tpl /etc/gotpl/vhost.conf.tpl
COPY templates/gitlab-pages.conf.tpl /etc/gotpl/gitlab-pages.conf.tpl

COPY init /docker-entrypoint-init.d/