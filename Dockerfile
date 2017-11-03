ARG FROM_TAG

FROM wodby/nginx:${FROM_TAG}

ENV NGINX_GITLAB_DATA_DIR="/mnt/data" \
    NGINX_GITLAB_PUBLIC_FILES_DIR="/mnt/data/public" \
    NGINX_USER="git"

USER root

RUN deluser nginx && \
    addgroup -S -g 1000 git && \
    adduser -u 1000 -D -S -s /bin/bash -G git git && \
    mkdir -p $NGINX_GITLAB_PUBLIC_FILES_DIR && \
    chown -R git:git /etc/nginx && \

    rm /etc/gotpl/default-vhost.conf.tpl && \

    # Configure sudoers
    { \
        echo -n 'git ALL=(root) NOPASSWD: ' ; \
        echo -n '/usr/local/bin/fix-permissions.sh, ' ; \
        echo '/usr/sbin/nginx' ; \
    } | tee /etc/sudoers.d/git && \
    rm /etc/sudoers.d/nginx

USER git

WORKDIR ${NGINX_GITLAB_PUBLIC_FILES_DIR}

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/