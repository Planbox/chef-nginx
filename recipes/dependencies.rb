# Dependencies
#
packages = value_for_platform(
  "default" => [
    "build-essential",
    "wget",
    "curl",
    "ssl-cert",
    "libpcre3-dev",
    "libssl-dev",
    "zlib1g-dev",
    "libluajit-5.1-dev",
    "libgeoip-dev"
  ]
)

packages.each do |core_dpkg|
  package core_dpkg do
    action  :install
  end
end
