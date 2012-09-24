# Version and prefix
#
nginx = "nginx-#{node["nginx"]["version"]}"
prefix = "#{node["library_path"]}/#{nginx}"

# Make options
# 
node["nginx"]["autoconf_opts"] = [
  "--prefix=#{prefix}",
  "--sbin-path=#{prefix}/sbin/nginx",
  "--pid-path=#{node["nginx"]["pid_path"]}/nginx.pid",
  "--lock-path=/var/lock/subsys/nginx",
  "--error-log-path=#{node["nginx"]["log_path"]}/error.log",
  "--http-log-path=#{node["nginx"]["log_path"]}/access.log",
  "--conf-path=#{node["nginx"]["conf_path"]}/nginx.conf",
  "--user=#{node["nginx"]["user"]}",
  "--group=#{node["nginx"]["user"]}"
]

# Make options (core modules)
#
node["nginx"]["core_modules"].each do |modname|
  node["nginx"]["autoconf_opts"].push(modname)
end

# Make options (user modules)
node["nginx"]["user_modules"].each do |(modname, moddata)|
  node["nginx"]["autoconf_opts"].push("--add-module=#{node["package_path"]}/nginx-#{modname}")
end

# Download and extract package
#
ark "Nginx :: install package (#{node["nginx"]["version"]})" do
  name          "nginx"
  url           "http://nginx.org/download/#{nginx}.tar.gz"
  version       node["nginx"]["version"]
  checksum      node["nginx"]["checksum"]
  autoconf_opts node["nginx"]["autoconf_opts"]
  has_binaries  ["sbin/nginx"]
  action        [:configure, :install_with_make]
end
