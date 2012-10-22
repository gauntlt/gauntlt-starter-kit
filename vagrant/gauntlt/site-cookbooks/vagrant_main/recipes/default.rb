#
# Cookbook Name:: vagrant_main
# Recipe:: default

include_recipe "build-essential"
include_recipe "apt"
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

# install sslyze
git "sslyze" do
    repository "https://github.com/iSECPartners/sslyze.git"
    reference "master"
    action :checkout
    destination "/home/vagrant/sslyze"
end

# update bashrc to support sslyze
cookbook_file "/home/vagrant/.bashrc" do
  source "vagrant.bashrc"
  mode "0644"
end

# attacks
directory "/home/vagrant/attacks" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

['nmap', 'sslyze'].each do |file|
  cookbook_file "/home/vagrant/attacks/#{file}" do
    source file
    mode "0644"
  end
end
