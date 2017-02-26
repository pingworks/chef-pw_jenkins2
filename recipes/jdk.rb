package 'openjdk-8-jdk' do
  options '--no-install-recommends'
end

jdk_dir = "java-8-openjdk-amd64"
link '/usr/lib/jvm/default-java' do
  to "/usr/lib/jvm/#{jdk_dir}"
end

# set java alternative but ignore all errors as some files
# seem to be missing for oracle jdk 7
bash 'set default java version' do
  user 'root'
  code "update-java-alternatives -s #{jdk_dir} || true"
end

directory '/etc/profile.d' do
  mode 0755
end

file '/etc/profile.d/jdk.sh' do
  content 'export JAVA_HOME=/usr/lib/jvm/default-java'
  mode 0755
end
