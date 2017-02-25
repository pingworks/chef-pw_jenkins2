package 'apache2'

cookbook_file 'apache-conf-jenkins.conf' do
  path '/etc/apache2/conf-available/jenkins.conf'
  owner 'root'
  group 'root'
  mode '644'
end

bash 'a2enmod proxy' do
  code 'a2enmod proxy'
end

bash 'a2enmod proxy_http' do
  code 'a2enmod proxy_http'
end

bash 'a2enconf jenkins' do
  code 'a2enconf jenkins'
end

bash 'restart apache' do
  code 'service apache2 restart'
end
