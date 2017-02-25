include_recipe 'apt'

if node['pw_jenkins2']['java']['install'] == true
  include_recipe 'pw_jenkins2::jdk'
end

include_recipe 'pw_jenkins2::_slave_install'

service 'jenkins-swarm-slave' do
  action [:enable, :start]
end
