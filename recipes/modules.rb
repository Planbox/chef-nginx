# Modules
#
node['nginx']['user_modules'].each do |(modname, (modgit, modver), moddeps)|
  git "#{Chef::Config[:file_cache_path]}/nginx-#{modname}" do
    repository  modgit
    revision    modver
    action      :sync
  end

  moddeps.each do |core_dpkg|
    package core_dpkg do
      action  :install
    end
  end
end
