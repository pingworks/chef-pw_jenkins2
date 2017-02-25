require_relative '../spec_helper'

# ----------------------------
# java setup
# ----------------------------

describe package('openjdk-7-jdk') do
  it { should be_installed.by('apt') }
end

describe command('sudo -i -u jenkins export | grep JAVA_HOME') do
  its(:stdout) { should match '/usr/lib/jvm/default-java' }
end
