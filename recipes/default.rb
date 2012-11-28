# Install requirements
#
include_recipe "nginx::dependencies"

# Download package
#
include_recipe "nginx::source"

# Download modules
#
include_recipe "nginx::modules"

# Compile package
#
include_recipe "nginx::install"

# Daemon user (www-data)
#
group node['nginx']['user'] do
  system  true
  action  :create
end
user node['nginx']['user'] do
  gid     node['nginx']['user']
  home    node['nginx']['http_docs']
  shell   "/bin/sh"
  system  true
  action  :create
end

# Daemon directories (run, log, ...)
#
node.set['nginx']['sites_available_path'] = "#{node['nginx']['conf_path']}/sites-available"
node.set['nginx']['sites_enabled_path']   = "#{node['nginx']['conf_path']}/sites-enabled"
node.set['nginx']['conf_path_main']   = "#{node['nginx']['conf_path']}/conf.d"
node.set['nginx']['conf_path_extra']  = "#{node['nginx']['conf_path']}/extra.d"
%w[http_docs log_path pid_path spool_path].each do |path|
  directory node['nginx'][path] do
    recursive true
    owner     node['nginx']['user']
    group     node['nginx']['user']
    mode      "0755"
    action    :create
  end
end

%w[conf_path sites_available_path sites_enabled_path conf_path_main conf_path_extra].each do |path|
  directory node['nginx'][path] do
    recursive true
    mode      "0755"
    action    :create
  end
end

node['nginx']['spools'].each do |(path, opts)|
  directory "#{node['nginx']['spool_path']}/#{path}" do
    recursive true
    owner     node['nginx']['user']
    group     node['nginx']['user']
    mode      "0755"
    action    :create
  end
end

# Startup script
#
template "/etc/init.d/nginx" do
  source  "init.nginx.erb"
  mode    "0755"
end

# Service
service "nginx" do
  supports  :start => true, :stop => true, :status => true, :reload => true, :restart => true
  action    :enable
end

# Configuration file
#
destination_file  = "#{node['nginx']['conf_path']}/nginx.conf"
if preserve false, destination_file
  destination_file  = "#{destination_file}.default"
end
template destination_file do
  source  "nginx.conf.erb"
  mode    "0644"
end

# Configuration files main
#
%w[buffer gzip limit proxy timeout].each do |filename|
  destination_file  = "#{node['nginx']['conf_path_main']}/#{filename}"
  if preserve false, destination_file
    destination_file  = "#{destination_file}.default"
  end
  template destination_file do
    source  "conf.#{filename}.erb"
    mode    "0644"
  end
end

# Configuration files static
#
%w[fastcgi fastcgi_ssl logformats mimetypes].each do |filename|
  destination_file  = "#{node['nginx']['conf_path_main']}/#{filename}"
  if preserve false, destination_file
    destination_file  = "#{destination_file}.default"
  end
  cookbook_file destination_file do
    source  filename
    mode    "0644"
  end
end

# Configuration files extra
#
%w[cross-domain-ajax cross-domain-fonts no-transform protect-system-files x-ua-compatible].each do |filename|
  destination_file  = "#{node['nginx']['conf_path_extra']}/#{filename}"
  if preserve false, destination_file
    destination_file  = "#{destination_file}.default"
  end
  cookbook_file destination_file do
    source  filename
    mode    "0644"
  end
end

# Default site
#
destination_file  = "#{node['nginx']['sites_available_path']}/000-default"
if preserve false, destination_file
  destination_file  = "#{destination_file}.default"
end
template destination_file do
  source  "site.default.erb"
  mode    "0644"
end
link "#{node['nginx']['sites_enabled_path']}/000-default" do
  to "#{node['nginx']['sites_available_path']}/000-default"
end

# Restart service
#
service "nginx" do
  action  :restart
end

