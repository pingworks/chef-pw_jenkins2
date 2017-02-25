#
# Cookbook Name:: jenkins
# Recipe:: master
# Author: Alexander Birk
#
include_recipe 'apt'

if node['pw_jenkins2']['java']['install'] == true
  include_recipe 'pw_jenkins2::jdk'
end

include_recipe 'pw_jenkins2::_master_install_from_deb'

# Install all plugins with correct versions
include_recipe 'pw_jenkins2::_master_install_plugins'

# Make sure that jenkins is up and running...
include_recipe 'pw_jenkins2::_master_ensure_jenkins_up'

if node['pw_jenkins2']['apache_proxy']['install'] == true
  include_recipe 'pw_jenkins2::_master_setup_apache_proxy'
end
