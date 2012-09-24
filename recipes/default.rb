# Install requirements
#
include_recipe "ark"
include_recipe "nginx::dependencies"

# Download modules
#
include_recipe "nginx::modules"

# Compile package
include_recipe "nginx::source"

# Create directories
#
bash "Nginx :: clear config directory" do
  code "rm -fr #{node["nginx"]["conf_path"]}/*"
end
node["nginx"]["incl_path"]  = "#{node["nginx"]["conf_path"]}/conf.d"
node["nginx"]["site_avl"]   = "#{node["nginx"]["conf_path"]}/sites-available"
node["nginx"]["site_enl"]   = "#{node["nginx"]["conf_path"]}/sites-enabled"

%w[conf_path pid_path log_path incl_path site_avl site_enl].each do |path|
  directory node["nginx"][path] do
    recursive true
    owner     node["nginx"]["user"]
    group     node["nginx"]["user"]
    mode      "0755"
    action    :create
  end
end

# Create service
#
template "Nginx :: install service" do
  path    "/etc/init.d/nginx"
  source  "nginx.init.erb"
  owner   "root"
  group   "root"
  mode    "0755"
end

service "Nginx :: enable service" do
  service_name  "nginx"
  supports      :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action        :enable
end

# Nginx configuration file
#
template "Nginx :: configuration file" do
  path    "#{node["nginx"]["conf_path"]}/nginx.conf"
  source  "nginx.conf.erb"
  owner   node["nginx"]["user"]
  group   node["nginx"]["user"]
  mode    "0644"
end

# Static configuration files
#
%w[fastcgi fastcgi_ssl logformats mimetypes].each do |path|
  cookbook_file "Nginx :: configuration file (#{path})" do
    path    "#{node["nginx"]["incl_path"]}/#{path}"
    source  path
    owner   node["nginx"]["user"]
    group   node["nginx"]["user"]
    mode    "0644"
  end
end

# Dynamic configuration files
# 
%w[buffer gzip limit timeout proxy].each do |path|
  template "Nginx :: configuration file (#{path})" do
    path    "#{node["nginx"]["incl_path"]}/#{path}"
    source  "conf.#{path}.erb"
    owner   node["nginx"]["user"]
    group   node["nginx"]["user"]
    mode    "0644"
  end
end

# Install nxdissite/nxensite
#
%w[nxensite nxdissite].each do |nxscript|
  template "/usr/sbin/#{nxscript}" do
    source  "#{nxscript}.erb"
    owner   "root"
    group   "root"
    mode    "0755"
  end
end

# Restart/Reload
#
service "Nginx :: restart (start)" do
  service_name  "nginx"
  action        :restart
end
