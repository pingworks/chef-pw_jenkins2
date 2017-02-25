# Apache Proxy
default['pw_jenkins2']['apache_proxy']['install'] = true

# Java Home
default['pw_jenkins2']['java']['install'] = true
default['pw_jenkins2']['java']['home'] = '/usr/lib/jvm/default-java'

# Jenkins version
default['pw_jenkins2']['master']['version'] = '2.47'

# DEPRECATED
# jenkins config git url
# default['pw_jenkins2']['master']['jenkins_config_git_url'] = ''

# Plugins to install, with exact Version Number
# (extracted from a real, prototype installation with:
# java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/jenkins/ list-plugins | sort | sed -r "s;\s{1,}; ;g; s; \([0-9.]{1,}\)$;;g; s;^([a-zA-Z0-9-]{1,}) .* ([0-9.-]{1,})$;['\1', '\2'],;"
default['pw_jenkins2']['master']['plugin_baseurl'] = 'https://updates.jenkins-ci.org/download/plugins/'
default['pw_jenkins2']['master']['plugin_list'] = [
  # ['ace-editor', '1.1'],
  # ['antisamy-markup-formatter', '1.5'],
  # ['branch-api', '1.10'],
  # ['cloudbees-folder', '5.12'],
  # ['credentials', '2.1.4'],
  # ['durable-task', '1.11'],
  # ['git-client', '1.19.6'],
  # ['git-server', '1.6'],
  # ['handlebars', '1.1.1'],
  # ['icon-shim', '2.0.3'],
  # ['jquery-detached', '1.2.1'],
  # ['junit', '1.13'],
  # ['mailer', '1.17'],
  # ['matrix-auth', '1.4'],
  # ['matrix-project', '1.7.1'],
  # ['momentjs', '1.1.1'],
  # ['pipeline-build-step', '2.1'],
  # ['pipeline-input-step', '2.0'],
  # ['pipeline-rest-api', '1.5'],
  # ['pipeline-stage-step', '2.1'],
  # ['pipeline-stage-view', '1.5'],
  # ['rebuild', '1.25'],
  # ['scm-api', '1.2'],
  # ['script-security', '1.20'],
  # ['slack', '2.0.1'],
  # ['ssh-credentials', '1.12'],
  # ['structs', '1.2'],
  # ['windows-slaves', '1.1'],
  # ['workflow-aggregator', '2.2'],
  # ['workflow-api', '2.1'],
  # ['workflow-basic-steps', '2.0'],
  # ['workflow-cps-global-lib', '2.0'],
  # ['workflow-cps', '2.8'],
  # ['workflow-durable-task-step', '2.3'],
  # ['workflow-job', '2.3'],
  # ['workflow-multibranch', '2.8'],
  # ['workflow-scm-step', '2.1'],
  # ['workflow-step-api', '2.2'],
  # ['workflow-support', '2.1']
]

# Jenkins installation urls
default['pw_jenkins2']['master']['install_method'] = 'download_deb'
default['pw_jenkins2']['master']['mirror'] = 'http://mirrors.jenkins-ci.org/plugins/'
default['pw_jenkins2']['master']['updatecenter'] = 'http://mirrors.jenkins-ci.org/updates/current/update-center.json'
default['pw_jenkins2']['master']['source'] = "http://pkg.jenkins-ci.org/debian/binary/jenkins_#{node['pw_jenkins2']['master']['version']}_all.deb"

default['pw_jenkins2']['master']['home'] = '/var/lib/jenkins'
default['pw_jenkins2']['master']['log_directory'] = '/var/log/jenkins'
default['pw_jenkins2']['master']['listen_address'] = '0.0.0.0'
default['pw_jenkins2']['master']['port'] = 8080
default['pw_jenkins2']['master']['jenkins_args'] = '--prefix=/jenkins'
default['pw_jenkins2']['master']['url'] = 'http://localhost:8080/jenkins'

# JVM options
default['pw_jenkins2']['master']['jvm_options'] = '-XX:MaxPermSize=1024m -Dorg.eclipse.jetty.server.Request.maxFormContentSize=500000'
default['pw_jenkins2']['slave']['jvm_options'] = '-XX:MaxPermSize=512m'

# slave config
default['pw_jenkins2']['slave']['home'] = '/var/lib/jenkins'
default['pw_jenkins2']['slave']['shell'] = '/bin/bash'
default['pw_jenkins2']['slave']['swarm_version'] = '2.0'
default['pw_jenkins2']['slave']['swarm_jar'] = "swarm-client-#{node['pw_jenkins2']['slave']['swarm_version']}-jar-with-dependencies.jar"
default['pw_jenkins2']['slave']['swarm_base_url'] = 'http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.0/'
default['pw_jenkins2']['slave']['master_url']           = 'http://jkmaster:8080/jenkins'
default['pw_jenkins2']['slave']['jenkins_ui_user']      = 'jenkins-ui-user'
default['pw_jenkins2']['slave']['jenkins_ui_password']  = 'jenkins-ui-password'
default['pw_jenkins2']['slave']['labels']               = ''
default['pw_jenkins2']['slave']['name']                 = ''
default['pw_jenkins2']['slave']['executors']            = '1'
default['pw_jenkins2']['slave']['options']              = '-disableClientsUniqueId'
