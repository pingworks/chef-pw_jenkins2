#
# Cookbook Name:: jenkins
# Recipe:: _master_download_package
#
# Author: Alexander Birk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'apt::default'

package 'daemon'
package 'unzip'
node['pw_jenkins']['master']['source']


Chef::Log.info("Downloading jenkins deb from #{node['pw_jenkins']['master']['source']} to #{Chef::Config[:file_cache_path]}/jenkins_#{node['pw_jenkins']['master']['version']}_all.deb")

# Download the remote DEB file
remote_file "#{Chef::Config[:file_cache_path]}/jenkins_#{node['pw_jenkins']['master']['version']}_all.deb" do
  source   node['pw_jenkins']['master']['source']
  checksum node['pw_jenkins']['master']['checksum'] if node['pw_jenkins']['master']['checksum']
  action :create_if_missing
end

# install the prerequisites for the jenkins-package
package 'psmisc'

dpkg_package "jenkins_#{node['pw_jenkins']['master']['version']}_all.deb" do
  options '--force-confdef'
  source "#{Chef::Config[:file_cache_path]}/jenkins_#{node['pw_jenkins']['master']['version']}_all.deb"
  version node['pw_jenkins']['master']['version']
  notifies :restart, 'service[jenkins]', :delayed
end

template "#{node['pw_jenkins']['master']['home']}/jenkins.install.InstallUtil.lastExecVersion" do
  owner 'jenkins'
  group 'jenkins'
  mode 00644
end

cookbook_file "#{node['pw_jenkins']['master']['home']}/config.xml" do
  owner 'jenkins'
  group 'jenkins'
  mode 00644
end

# cp jenkins-cli.jar to /usr/local/lib/jenkins/jenkins-cli.jar
directory '/usr/local/lib/jenkins' do
  owner 'root'
  group 'staff'
  mode '0755'
end

ark 'jenkins-cli' do
  url 'file:///usr/share/jenkins/jenkins.war'
  path '/usr/local/lib/jenkins'
  creates 'jenkins-cli.jar'
  action :cherry_pick
  not_if { ::File.exist? '/usr/local/lib/jenkins-cli.jar' }
end

file '/usr/local/lib/jenkins/jenkins-cli.jar' do
  owner 'root'
  group 'staff'
  mode '0644'
end

template '/etc/default/jenkins' do
  source   'jenkins-config-debian.erb'
  mode     '0644'
  notifies :restart, 'service[jenkins]', :delayed
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action  [:enable, :start]
end

directory '/var/lib/jenkins/build.properties' do
  owner 'jenkins'
  group 'jenkins'
  mode '755'
end
