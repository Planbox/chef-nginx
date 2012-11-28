name              "nginx"
maintainer        "Soban Vuex"
maintainer_email  "soban.vuex@gmail.com"
license           "MIT"
description       "Install Nginx from source"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"


provides          "nginx"
provides          "nginx::dependencies"
provides          "nginx::source"
provides          "nginx::modules"
provides          "nginx::install"