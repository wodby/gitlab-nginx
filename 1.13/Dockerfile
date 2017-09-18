FROM wodby/nginx:1.13

ENV GITLAB_NGINX_PUBLIC_DIR /mnt/data/public

RUN rm /etc/gotpl/default-vhost.conf.tpl

COPY gitlab.conf.tpl /etc/gotpl/
COPY init/* /docker-entrypoint-init.d/