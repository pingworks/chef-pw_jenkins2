include_recipe 'apt'

if node['pw_jenkins']['java']['install'] == true
  include_recipe 'pw_jenkins::jdk'
end

include_recipe 'pw_jenkins::_slave_install'

service 'jenkins-swarm-slave' do
  action [:enable, :start]
end
