# Package information
#
default[:nginx][:version]         = "1.2.5"
default[:nginx][:source]          = "http://nginx.org/download"
default[:nginx][:preserve_files]  = true

default[:nginx][:core_modules]  = [
  "--without-http_memcached_module",
  "--without-http_scgi_module",
  "--without-http_ssi_module",
  "--without-http_uwsgi_module",
  "--with-http_ssl_module",
  "--with-http_realip_module",
  "--with-http_geoip_module",
  "--with-http_gzip_static_module",
  "--with-http_secure_link_module"
]
default[:nginx][:user_modules]  = [
  ["devel-kit", ["https://github.com/simpl/ngx_devel_kit.git", "master"]],
  ["set-misc", ["https://github.com/agentzh/set-misc-nginx-module.git", "master"]],
  ["chunkin", ["https://github.com/agentzh/chunkin-nginx-module.git", "master"]],
  ["echo", ["https://github.com/agentzh/echo-nginx-module.git", "master"]],
  ["headers-more", ["https://github.com/agentzh/headers-more-nginx-module.git", "v0.19"]],
  ["lua", ["https://github.com/chaoslawful/lua-nginx-module.git", "v0.7.5"]],
  ["push-stream", ["https://github.com/wandenberg/nginx-push-stream-module.git", "master"]],
  ["redis2", ["https://github.com/agentzh/redis2-nginx-module.git", "v0.09"]],
  ["upload-progress", ["https://github.com/masterzen/nginx-upload-progress-module.git", "v0.9.0"]],
  ["upstream-fair", ["https://github.com/gnosek/nginx-upstream-fair.git", "master"]]
]

#] Paths
#
default[:nginx][:user]        = "www-data"
default[:nginx][:http_docs]   = "/var/www"
default[:nginx][:prefix_path] = "/opt/lib"
default[:nginx][:conf_path]   = "/opt/etc/nginx"
default[:nginx][:log_path]    = "/var/log/nginx"
default[:nginx][:pid_path]    = "/var/run/nginx"
default[:nginx][:spool_path]  = "/var/spool/nginx"

# Temporary files
#
default[:nginx][:spools] = [
  ["client-body", "--http-client-body-temp-path"],
  ["proxy", "--http-proxy-temp-path"],
  ["fastcgi", "--http-fastcgi-temp-path"],
  ["uwsgi", "--http-uwsgi-temp-path"],
  ["scgi", "--http-scgi-temp-path"]
]

# Configuration
#
default[:nginx][:worker_proc]   = 8
default[:nginx][:worker_rlimit] = 8192
default[:nginx][:worker_conn]   = 16384

default[:nginx][:default_type]        = "text/plain"
default[:nginx][:index]               = ["index.html", "index.php"]
default[:nginx][:sendfile]            = "on"
default[:nginx][:tcp_nopush]          = "on"
default[:nginx][:tcp_nodelay]         = "off"
default[:nginx][:server_tokens]       = "off"
default[:nginx][:block_referral_spam] = true

default[:nginx][:listen]  = ["80 default_server", "443 ssl"]

default[:nginx][:client_body_buffer_size]     = "1m"
default[:nginx][:client_header_buffer_size]   = "4k"
default[:nginx][:client_max_body_size]        = "30m"
default[:nginx][:large_client_header_buffers] = "4 8k"

default[:nginx][:gzip]              = "on"
default[:nginx][:gzip_http_version] = "1.0"
default[:nginx][:gzip_min_lenght]   = 1000
default[:nginx][:gzip_comp_level]   = 5
default[:nginx][:gzip_buffers]      = "4 8k"
default[:nginx][:gzip_proxied]      = ["any"]
default[:nginx][:gzip_types]        = ["text/plain", "text/css", "text/x-component",
  "application/javascript", "application/json", "application/xml", "application/xhtml+xml",
  "application/x-font-ttf", "application/x-font-opentype", "application/vnd.ms-fontobject",
  "image/svg+xml", "image/x-icon"]
default[:nginx][:gzip_static]       = "off"
default[:nginx][:gzip_disable]      = "msie6"
default[:nginx][:gzip_vary]         = "on"

default[:nginx][:limit_zone_http]     = "20m"
default[:nginx][:limit_zone_server]   = "10m"
default[:nginx][:limit_zone_revproxy] = "5m"
default[:nginx][:limit_zone_cgiproxy] = "5m"
default[:nginx][:limit_http]          = 100

default[:nginx][:client_body_timeout]   = 20
default[:nginx][:client_header_timeout] = 10
default[:nginx][:keepalive_timeout]     = [100, 20]
default[:nginx][:send_timeout]          = 20

default[:nginx][:proxy_connect_timeout] = 60
default[:nginx][:proxy_send_timeout]    = 60
default[:nginx][:proxy_read_timeout]    = 120
default[:nginx][:proxy_buffers]         = "64 8k"
