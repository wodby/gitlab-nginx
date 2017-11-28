ARG FROM_TAG

FROM wodby/nginx:${FROM_TAG}

USER root

ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/master/public/404.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/master/public/422.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/master/public/500.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/master/public/502.html /etc/nginx/gitlab/
ADD https://gitlab.com/gitlab-org/gitlab-ce/raw/master/public/503.html /etc/nginx/gitlab/

RUN deluser nginx && \
    addgroup -S -g 1000 git && \
    adduser -u 1000 -D -S -s /bin/bash -G git git && \
    chown -R git:git /etc/nginx && \

    rm /etc/gotpl/default-vhost.conf.tpl && \
    echo 'git ALL=(root) NOPASSWD: /usr/sbin/nginx' > /etc/sudoers.d/git && \
    rm /etc/sudoers.d/nginx

USER git

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/