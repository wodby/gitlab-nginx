map $http_upgrade $connection_upgrade_gitlab {
    default upgrade;
    ''      close;
}

## Normal HTTP host
server {
  server_name {{ getenv "NGINX_SERVER_NAME" "gitlab" }};
  server_tokens off; ## Don't show the nginx version number, a security best practice

  ## See app/controllers/application_controller.rb for headers set
  add_header X-Accel-Buffering {{ getenv "GITLAB_NGINX_ACCEL_BUFFERING" "no" }};

  location / {
    client_max_body_size 0;
    gzip off;

    ## https://github.com/gitlabhq/gitlabhq/issues/694
    ## Some requests take more than 30 seconds.
    proxy_read_timeout      300;
    proxy_connect_timeout   300;
    proxy_redirect          off;
    proxy_buffering         {{ getenv "NGINX_PROXY_BUFFERING" "off" }};

    proxy_http_version 1.1;

    proxy_set_header    Host                $http_host;
    proxy_set_header    X-Real-IP           $remote_addr;
    proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
    proxy_set_header    X-Forwarded-Proto   $scheme;
    proxy_set_header    Upgrade             $http_upgrade;
    proxy_set_header    Connection          $connection_upgrade_gitlab;

    proxy_pass http://backend;
  }

  error_page 404 /404.html;
  error_page 422 /422.html;
  error_page 500 /500.html;
  error_page 502 /502.html;
  error_page 503 /503.html;
  location ~ ^/(404|422|500|502|503)\.html$ {
    root {{ getenv "GITLAB_NGINX_PUBLIC_DIR" }};
    internal;
  }
}
