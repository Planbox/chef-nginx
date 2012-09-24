# Modules
#
node["nginx"]["user_modules"].each do |(modname, (modgit, modver))|
  ark "Nginx :: Module(#{modname})" do
    name      "nginx-#{modname}"
    url       "https://github.com/#{modgit}/tarball/#{modver}"
    extension "tar.gz"
    version   modver
    path      node["package_path"]
    action    :put
  end
end