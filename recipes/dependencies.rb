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
    "lua5.1",
    "liblua5.1-0-dev",
    "libgeoip-dev"
  ]
)

# Install using package manager
packages.each do |core_dpkg|
  package core_dpkg do
    action  :install
  end
end