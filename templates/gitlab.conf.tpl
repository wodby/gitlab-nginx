upstream gitlab-workhorse {
  server  {{ getenv "NGINX_WORKHORSE_HOST" "workhorse:8181" }} fail_timeout=0;
}

map $http_upgrade $connection_upgrade_gitlab {
    default upgrade;
    ''      close;
}

log_format gitlab_access $remote_addr - $remote_user [$time_local] "$request_method $gitlab_filtered_request_uri $server_protocol" $status $body_bytes_sent "$gitlab_filtered_http_referer" "$http_user_agent";

map $request_uri $gitlab_temp_request_uri_1 {
  default $request_uri;
  ~(?i)^(?<start>.*)(?<temp>[\?&]private[\-_]token)=[^&]*(?<rest>.*)$ "$start$temp=[FILTERED]$rest";
}

map $gitlab_temp_request_uri_1 $gitlab_temp_request_uri_2 {
  default $gitlab_temp_request_uri_1;
  ~(?i)^(?<start>.*)(?<temp>[\?&]authenticity[\-_]token)=[^&]*(?<rest>.*)$ "$start$temp=[FILTERED]$rest";
}

map $gitlab_temp_request_uri_2 $gitlab_filtered_request_uri {
  default $gitlab_temp_request_uri_2;
  ~(?i)^(?<start>.*)(?<temp>[\?&]rss[\-_]token)=[^&]*(?<rest>.*)$ "$start$temp=[FILTERED]$rest";
}

map $http_referer $gitlab_filtered_http_referer {
  default $http_referer;
  ~^(?<temp>.*)\? $temp;
}

server {
  listen 0.0.0.0:80 default_server;
  listen [::]:80 default_server;
  server_name {{ getenv "NGINX_SERVER_NAME" "gitlab" }};
  server_tokens off; ## Don't show the nginx version number, a security best practice

  real_ip_header X-Real-IP; ## X-Real-IP or X-Forwarded-For or proxy_protocol
  real_ip_recursive off;    ## If you enable 'on'

  include healthz.conf;

  location / {
    client_max_body_size 0;
    gzip off;

    proxy_read_timeout      300;
    proxy_connect_timeout   300;
    proxy_redirect          off;

    proxy_http_version 1.1;

    proxy_set_header    Host                $http_host;
    proxy_set_header    X-Real-IP           $remote_addr;
    proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
    proxy_set_header    X-Forwarded-Proto   $scheme;
    proxy_set_header    Upgrade             $http_upgrade;
    proxy_set_header    Connection          $connection_upgrade_gitlab;
{{ if (getenv "GITLAB_HTTPS") }}
    proxy_set_header    X-Forwarded-Ssl     on;
{{ end }}
    proxy_pass http://gitlab-workhorse;
  }

  error_page 404 /404.html;
  error_page 422 /422.html;
  error_page 500 /500.html;
  error_page 502 /502.html;
  error_page 503 /503.html;
  location ~ ^/(404|422|500|502|503)\.html$ {
    root /etc/nginx/gitlab;
    internal;
  }

}