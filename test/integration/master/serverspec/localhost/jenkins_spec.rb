require_relative '../spec_helper'

# ----------------------------
# jenkins version & setup
# ----------------------------

describe package('jenkins') do
  it { should be_installed.by('apt').with_version('1.609.3') }
end

describe process('java') do
  its(:args) { should match '-jar /usr/share/jenkins/jenkins.war' }
end

describe process('java') do
  its(:args) { should match '--httpPort=8080' }
end

describe port(8080) do
  it { should be_listening }
end

describe process('daemon') do
  its(:args) { should match '--env=JENKINS_HOME=/var/lib/jenkins' }
end

describe user('jenkins') do
  it { should have_home_directory '/var/lib/jenkins' }
end

describe file('/usr/local/lib/jenkins') do
  it { should be_directory }
  it { should be_mode('755') }
end

describe file('/usr/local/lib/jenkins/jenkins-cli.jar') do
  it { should be_file }
  it { should be_readable.by('others') }
end

# See bats Test for plugins verification tests (i.e. plugins expected, plugin versions expected, number of plugins)
