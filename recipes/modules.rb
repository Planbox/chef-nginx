# Modules
#
node[:nginx][:user_modules].each do |(modname, (modgit, modver))|
  git "#{Chef::Config[:file_cache_path]}/nginx-#{modname}" do
    repository  modgit
    reference   modver
    action      :sync
  end
end
