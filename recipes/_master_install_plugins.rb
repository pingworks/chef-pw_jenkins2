# Install Jenkins plugins

template "#{node['pw_jenkins']['master']['home']}/hudson.model.UpdateCenter.xml" do
  source   'hudson.model.UpdateCenter.erb'
  mode     '0644'
end

directory '/var/lib/jenkins/plugins' do
  mode '0755'
  owner 'jenkins'
  group 'jenkins'
end

# Please define the exact plugin_list in the attributes/default.rb file

plugins_to_be_installed = []
node['pw_jenkins']['master']['plugin_list'].each_with_index do |plugin, _i|
  plugin_version_installed = ''
  plugin_manifest = "/var/lib/jenkins/plugins/#{plugin[0]}/META-INF/MANIFEST.MF"
  if File.file?(plugin_manifest)
    File.open(plugin_manifest) do |file|
      file.each_line do |line|
        if line =~ /^Plugin-Version:/
          plugin_version_installed = line.chomp.gsub(/^Plugin-Version:\s/, '')
          break
        end
      end
    end
    Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" Version installed: \"#{plugin_version_installed}\""
  else
    Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" is not installed yet!"
  end

  Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" Version desired:   \"#{plugin[1]}\""

  if !plugin_version_installed.eql? plugin[1]
    Chef::Log.info "Will INSTALL Jenkins Plugin #{plugin[0]}@#{plugin[1]}"
    plugins_to_be_installed.push([plugin[0], plugin[1], plugin[2]])
  else
    Chef::Log.info "Jenkins Plugin \"#{plugin[0]}\" is already UPTODATE."
  end
end

plugins_to_be_installed.each_with_index do |plugin, i|
  baseurl = node['pw_jenkins']['master']['plugin_baseurl']
  plugin[2].nil? || baseurl = plugin[2]
  Chef::Log.info "Now installing Jenkins Plugin #{plugin[0]}@#{plugin[1]} from #{baseurl}"
  remote_file "/var/lib/jenkins/plugins/#{plugin[0]}.hpi" do
    source "#{baseurl}/#{plugin[0]}/#{plugin[1]}/#{plugin[0]}.hpi"
  end
end

if (plugins_to_be_installed.size >= 0) then
  execute 'restart-jenkins' do
    command 'echo w00t'
    notifies :restart, 'service[jenkins]', :immediately
  end
end
