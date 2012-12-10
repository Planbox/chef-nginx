# Package
#
remote_file "#{Chef::Config[:file_cache_path]}/nginx-#{node['nginx']['version']}.tar.gz" do
  source  "#{node['nginx']['source']}/nginx-#{node['nginx']['version']}.tar.gz"
  action  :create_if_missing
end
