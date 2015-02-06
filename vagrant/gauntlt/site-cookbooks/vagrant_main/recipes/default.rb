#
# Cookbook Name:: vagrant_main
# Recipe:: default

include_recipe "build-essential"
include_recipe "apt"
include_recipe "git"

# install distro packages for building gems
['ruby1.9.1-dev', 'libxml2', 'libxml2-dev', 'libxslt-dev'].each do |pkg|
  package pkg do
    action :install
  end
end

# install distro packages for attack tools
['nmap', 'w3af-console' ].each do |pkg|
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

execute "install gems" do
  command "/usr/bin/ruby -S gem install gauntlt bundler arachni"
end

# install sslyze
git "sslyze" do
    repository "https://github.com/iSECPartners/sslyze.git"
    reference "master"
    action :checkout
    destination "/home/vagrant/sslyze"
    user "vagrant"
    group "vagrant"
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

# install gauntlt-demo
git "gauntlt-demo" do
    repository "https://github.com/gauntlt/gauntlt-demo.git"
    reference "master"
    action :checkout
    destination "/home/vagrant/gauntlt-demo"
    user "vagrant"
    group "vagrant"
end


# set up gauntlt-demo
execute "gauntlt-demo setup" do
  user "vagrant"
  command "cd /home/vagrant/gauntlt-demo && git submodule update --init --recursive && bundle && bundle install && bundle exec start_services &"
end




# set up gauntlt-demo
# execute "gauntlt-demo setup part 1 (Initialize Submodules)" do
#  user "vagrant"
#  command "cd /home/vagrant/gauntlt-demo && rm -f .initialized && git submodule update --init --recursive && touch .initialized"
#  creates "/home/vagrant/gauntlt-demo/.initialized"
#end

#execute "gauntlt-demo setup part 2 (Install Gems)" do
#  user "vagrant"
#  command "cd /home/vagrant/gauntlt-demo && /usr/bin/ruby -S bundle && cd vendor/railsgoat && /usr/bin/ruby -S bundle"
#end

#execute "gauntlt-demo setup part 3 (Start Services)" do
#  user "vagrant"
#  command "cd /home/vagrant/gauntlt-demo && bundle exec start_services &"
#end
