# Load settings from data bag "nginx/settings" -
#
settings = Chef::DataBagItem.load("nginx", "settings") rescue {}

# === Package information ===
#
default["nginx"]["version"]       = "1.2.3"
default["nginx"]["checksum"]      = "06a1153b32b43f100ee9147fe230917deea648f0155111c749e35da120646bf5"
default["nginx"]["core_modules"]  = [
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
default["nginx"]["user_modules"]  = [
  ["ngx_devel_kit", ["simpl/ngx_devel_kit", "master"]],
  ["headers-more-nginx-module", ["agentzh/headers-more-nginx-module", "v0.18"]],
  ["lua-nginx-module", ["chaoslawful/lua-nginx-module", "v0.6.6"]],
  ["redis2-nginx-module", ["agentzh/redis2-nginx-module", "v0.09"]],
  ["set-misc-nginx-module", ["agentzh/set-misc-nginx-module", "v0.22rc8"]]
]

# === Paths ===
#
default["nginx"]["user"]      = "www-data"
default["nginx"]["conf_path"] = "/etc/nginx"
default["nginx"]["log_path"]  = "/var/log/nginx"
default["nginx"]["pid_path"]  = "/var/run/nginx"

# === Configuration ===
#

default["nginx"]["worker_proc"]   = 4
default["nginx"]["worker_rlimit"] = 8192
default["nginx"]["worker_conn"]   = 16384

default["nginx"]["default_type"]        = "text/plain"
default["nginx"]["block_referral_spam"] = true

default["nginx"]["listen"]  = ["80", "433 default_server ssl"]

default["nginx"]["client_body_buffer_size"]     = "4k"
default["nginx"]["client_header_buffer_size"]   = "4k"
default["nginx"]["client_max_body_size"]        = "30m"
default["nginx"]["large_client_header_buffers"] = "4 8k"

default["nginx"]["gzip"]              = "on"
default["nginx"]["gzip_min_lenght"]   = 1000
default["nginx"]["gzip_buffers"]      = "16 8k"
default["nginx"]["gzip_types"]        = ["text/plain", "text/css", "application/json",
  "application/x-javascript", "text/xml", "application/xml", "application/xml+rss", "text/javascript"]
default["nginx"]["gzip_proxied"]      = ["any"]
default["nginx"]["gzip_http_version"] = "1.1"
default["nginx"]["gzip_comp_level"]   = 6
default["nginx"]["gzip_vary"]         = "on"
default["nginx"]["gzip_disable"]      = "msie6"

default["nginx"]["limit_zone_http"]     = "20m"
default["nginx"]["limit_zone_server"]   = "10m"
default["nginx"]["limit_zone_revproxy"] = "5m"
default["nginx"]["limit_zone_cgiproxy"] = "5m"
default["nginx"]["limit_http"]          = 100

default["nginx"]["client_body_timeout"]   = 20
default["nginx"]["client_header_timeout"] = 10
default["nginx"]["keepalive_timeout"]     = [100, 20]
default["nginx"]["send_timeout"]          = 20

default["nginx"]["proxy_connect_timeout"] = 60
default["nginx"]["proxy_send_timeout"]    = 60
default["nginx"]["proxy_read_timeout"]    = 60
default["nginx"]["proxy_buffers"]         = "64 8k"
