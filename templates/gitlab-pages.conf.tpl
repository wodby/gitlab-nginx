server {
  listen 0.0.0.0:80;
  listen [::]:80 ipv6only=on;

  server_name ~^.*\.{{ getenv "NGINX_PAGES_SERVER_NAME_REGEX" }}$;

  include healthz.conf;

  location / {
    proxy_set_header    Host                $http_host;
    proxy_set_header    X-Real-IP           $remote_addr;
    proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
    proxy_set_header    X-Forwarded-Proto   $scheme;

    proxy_cache off;

    proxy_pass {{ getenv "GITLAB_PAGES_URL" "http://pages:8090" }};
  }

  error_page 403 /etc/nginx/gitlab/403.html;
  error_page 404 /etc/nginx/gitlab/404.html;
}
