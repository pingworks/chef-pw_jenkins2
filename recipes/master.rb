#
# Cookbook Name:: jenkins
# Recipe:: master
# Author: Alexander Birk
#
include_recipe 'apt'

if node['pw_jenkins']['java']['install'] == true
  include_recipe 'pw_jenkins::jdk'
end

include_recipe 'pw_jenkins::_master_install_from_deb'

# Install all plugins with correct versions
include_recipe 'pw_jenkins::_master_install_plugins'

# Make sure that jenkins is up and running...
include_recipe 'pw_jenkins::_master_ensure_jenkins_up'

if node['pw_jenkins']['apache_proxy']['install'] == true
  include_recipe 'pw_jenkins::_master_setup_apache_proxy'
end
