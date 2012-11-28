# Options
#
node.set[:nginx][:install_path] = "#{node[:nginx][:prefix_path]}/nginx-#{node[:nginx][:version]}"
node.set[:nginx][:binary_file]  = "#{node[:nginx][:install_path]}/sbin/nginx"

# Make options
#
node.set[:nginx][:configure_flags] = [
  "--prefix=#{node[:nginx][:install_path]}",
  "--sbin-path=#{node[:nginx][:sbin_path]}",
  "--pid-path=#{node[:nginx][:pid_path]}/nginx.pid",
  "--lock-path=/var/lock/subsys/nginx",
  "--error-log-path=#{node[:nginx][:log_path]}/error.log",
  "--http-log-path=#{node[:nginx][:log_path]}/access.log",
  "--conf-path=#{node[:nginx][:conf_path]}/nginx.conf",
  "--user=#{node[:nginx][:user]}",
  "--group=#{node[:nginx][:user]}"
]

# Make options (core modules)
#
node[:nginx][:core_modules].each do |mod_name|
  node[:nginx][:configure_flags].push mod_name
end

# Make options (user modules)
#
node[:nginx][:user_modules].each do |(mod_name, mod_data)|
  node[:nginx][:configure_flags].push "--add-module=#{Chef::Config[:file_cache_path]}/nginx-#{mod_name}"
end

# Make options (spool)
#
node[:nginx][:spools].each do |(option_path, option_name)|
  node[:nginx][:configure_flags].push "#{option_name}=#{node[:nginx][:spool_path]}/#{option_path}"
end

configure_flags = node[:nginx][:configure_flags].join(" ")

# Compile
#
bash "./configure --prefix=#{node[:nginx][:install_path]}" do
  cwd Chef::Config[:file_cache_path]
  code <<-BASH
    tar -zxf nginx-#{node[:nginx][:version]}.tar.gz
    cd nginx-#{node[:nginx][:version]}
    ./configure #{configure_flags}
    #{node[:nginx][:make_command]}
  BASH
end

# Manual install, because of file mess
#
compile_path  = "#{Chef::Config[:file_cache_path]}/nginx-#{node[:nginx][:version]}"

directory "#{node[:nginx][:install_path]}/sbin" do
  recursive true
  mode      "0755"
end

bash "mv #{node[:nginx][:binary_file]} #{node[:nginx][:binary_file]}.old" do
  code    "mv #{node[:nginx][:binary_file]} #{node[:nginx][:binary_file]}.old"
  only_if { File.exists?node[:nginx][:binary_file] }
end
bash "cp #{compile_path}/objs/nginx #{node[:nginx][:binary_file]}" do
  code "cp #{compile_path}/objs/nginx #{node[:nginx][:binary_file]}"
end

directory "#{node[:nginx][:install_path]}/html" do
  recursive true
  mode      "0755"
  action    :create
end

Dir.chdir("#{compile_path}/html") do
  Dir.glob("*") do |filename|
    source_file       = "#{compile_path}/html/#{filename}"
    destination_file  = "#{node[:nginx][:install_path]}/html/#{filename}"

    if preserve source_file, destination_file
      bash "cp #{source_file} #{destination_file}.default" do
        code  "cp #{source_file} #{destination_file}.default"
      end
    else
      bash "cp #{source_file} #{destination_file}" do
        code  "cp #{source_file} #{destination_file}"
      end
    end

  end
end

