#
# Cookbook Name:: vagrant_main
# Recipe:: default

require_recipe "build-essential"
# require_recipe "apt"
# require_recipe "tar"
# require_recipe "git"

# install distro packages for building gems
['ruby1.9.3', 'libxml2', 'libxml2-dev', 'libxslt-dev', ].each do |pkg|
  package pkg do
    action :install
  end
end

# install distro packages for attack tools
['nmap', 'w3af-console', ].each do |pkg|
  package pkg do
    action :install
  end
end

# install distro packages for arachni
['libcurl4-openssl-dev', 'libsqlite3-dev',  
  'libyaml-dev', 'zlib1g-dev', 'ruby1.9.1-dev'].each do |pkg|
  package pkg do
    action :install
  end
end


# install gems
['gauntlt', 'arachni'].each do |pkg|
  gem_package pkg do
    action :install
  end
end