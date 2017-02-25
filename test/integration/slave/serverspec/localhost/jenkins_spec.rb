require_relative '../spec_helper'
require 'busser/rubygems'

Busser::RubyGems.install_gem('faraday', '~> 0.9.0')
require 'faraday'

# ----------------------------
# jenkins version & setup
# ----------------------------

describe process('java') do
  its(:args) { should match '-jar \/var\/lib\/jenkins\/swarm-slave.jar' }
end

describe process('java') do
  its(:args) { should match '-executors 1' }
end

describe process('java') do
  its(:args) { should match "-master #{$node['pw_jenkins2']['slave']['master_url']}" }
end

describe process('java') do
  its(:args) { should match '-fsroot \/var\/lib\/jenkins' }
end

describe process('java') do
  its(:args) { should match '-labels Swarm' }
end

describe user('jenkins') do
  it { should have_home_directory '/var/lib/jenkins' }
end

describe command("wget -O - \"#{$node['pw_jenkins2']['slave']['master_url']}/computer/#{$node['pw_jenkins2']['slave']['name']}\"") do
  its(:stdout) { should match /#{$node['ipaddress']}.*Connected via JNLP agent./ }
end
