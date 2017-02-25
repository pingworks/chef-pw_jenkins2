# jenkins slave:
swarm_jar = node['pw_jenkins']['slave']['swarm_jar']
swarm_url = "#{node['pw_jenkins']['slave']['swarm_base_url']}/#{node['pw_jenkins']['slave']['swarm_jar']}"
slave_home = node['pw_jenkins']['slave']['home']
slave_shell = node['pw_jenkins']['slave']['shell']
username = 'jenkins'

# setup jenkins user and home
user username do
  home slave_home
  shell slave_shell
  manage_home true
end

directory slave_home do
  owner username
end

# install swarm jar
remote_file "#{slave_home}/#{swarm_jar}" do
  source swarm_url
  headers 'Host' => URI.parse(source.first).host
  action :create_if_missing
  notifies :restart, 'service[jenkins-swarm-slave]', :delayed
end

link "#{slave_home}/swarm-slave.jar" do
  to "#{slave_home}/#{swarm_jar}"
end

# install init.d and defaults file
template '/etc/init.d/jenkins-swarm-slave' do
  source 'slave_init_script.erb'
  mode '755'
  notifies :restart, 'service[jenkins-swarm-slave]', :delayed
end

template '/etc/default/jenkins-swarm-slave' do
  if node['pw_jenkins']['slave']['name'] == '' \
    && node.key?('pw_base') \
    && node['pw_base'].key?('cname') \
    && node['pw_base']['cname'] != ''
    node.default['pw_jenkins']['slave']['name'] = node['pw_base']['cname']
  end
  source 'slave_default_file.erb'
  mode '0644'
  notifies :restart, 'service[jenkins-swarm-slave]', :delayed
end

# configure log dir
directory '/var/log/jenkins' do
  owner username
end
