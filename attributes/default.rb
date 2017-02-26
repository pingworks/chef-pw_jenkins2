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
# java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/jenkins/ list-plugins | sort | sed -r "s;\s{1,}; ;g; s; \([0-9.]{1,}\)$;;g; s;^([a-zA-Z0-9-]{1,}) .* ([b0-9.-]{1,})$;['\1', '\2'],;"
default['pw_jenkins2']['master']['plugin_baseurl'] = 'http://updates.jenkins-ci.org/download/plugins/'

# These are the "community suggested" plugins (as of 2017-02-26)
default['pw_jenkins2']['master']['plugin_list'] = [
  ['ace-editor', '1.1'],
  ['ant', '1.4'],
  ['antisamy-markup-formatter', '1.5'],
  ['authentication-tokens', '1.3'],
  ['bouncycastle-api', '2.16.0'],
  ['branch-api', '2.0.7'],
  ['build-timeout', '1.18'],
  ['cloudbees-folder', '5.18'],
  ['credentials-binding', '1.10'],
  ['credentials', '2.1.12'],
  ['display-url-api', '1.1.1'],
  ['docker-commons', '1.6'],
  ['docker-workflow', '1.10'],
  ['durable-task', '1.13'],
  ['email-ext', '2.57'],
  ['external-monitor-job', '1.7'],
  ['git-client', '2.2.1'],
  ['git', '3.0.5'],
  ['github-api', '1.84'],
  ['github-branch-source', '2.0.3'],
  ['github', '1.26.0'],
  ['github-organization-folder', '1.6'],
  ['git-server', '1.7'],
  ['gradle', '1.26'],
  ['greenballs', '1.15'],
  ['handlebars', '1.1.1'],
  ['icon-shim', '2.0.3'],
  ['jquery-detached', '1.2.1'],
  ['junit', '1.20'],
  ['ldap', '1.14'],
  ['mailer', '1.19'],
  ['mapdb-api', '1.0.9.0'],
  ['matrix-auth', '1.4'],
  ['matrix-project', '1.8'],
  ['momentjs', '1.1.1'],
  ['pam-auth', '1.3'],
  ['pipeline-build-step', '2.4'],
  ['pipeline-github-lib', '1.0'],
  ['pipeline-graph-analysis', '1.3'],
  ['pipeline-input-step', '2.5'],
  ['pipeline-milestone-step', '1.3'],
  ['pipeline-model-api', '1.0.2'],
  ['pipeline-model-declarative-agent', '1.0.2'],
  ['pipeline-model-definition', '1.0.2'],
  ['pipeline-rest-api', '2.5'],
  ['pipeline-stage-step', '2.2'],
  ['pipeline-stage-tags-metadata', '1.0.2'],
  ['pipeline-stage-view', '2.5'],
  ['plain-credentials', '1.4'],
  ['resource-disposer', '0.6'],
  ['scm-api', '2.0.7'],
  ['script-security', '1.26'],
  ['ssh-credentials', '1.13'],
  ['ssh-slaves', '1.13'],
  ['structs', '1.6'],
  ['subversion', '2.7.1'],
  ['timestamper', '1.8.8'],
  ['token-macro', '2.0'],
  ['windows-slaves', '1.2'],
  ['workflow-aggregator', '2.5'],
  ['workflow-api', '2.11'],
  ['workflow-basic-steps', '2.4'],
  ['workflow-cps-global-lib', '2.6'],
  ['workflow-cps', '2.28'],
  ['workflow-durable-task-step', '2.9'],
  ['workflow-job', '2.10'],
  ['workflow-multibranch', '2.12'],
  ['workflow-scm-step', '2.3'],
  ['workflow-step-api', '2.9'],
  ['workflow-support', '2.13'],
  ['ws-cleanup', '0.32'],
  # Blueocean specific:
  ['blueocean-autofavorite', '0.6'],
  ['blueocean', '1.0.0-b24'],
  ['blueocean-commons', '1.0.0-b24'],
  ['blueocean-config', '1.0.0-b24'],
  ['blueocean-dashboard', '1.0.0-b24'],
  ['blueocean-display-url', '1.5.1'],
  ['blueocean-events', '1.0.0-b24'],
  ['blueocean-github-pipeline', '1.0.0-b24'],
  ['blueocean-git-pipeline', '1.0.0-b24'],
  ['blueocean-i18n', '1.0.0-b24'],
  ['blueocean-jwt', '1.0.0-b24'],
  ['blueocean-personalization', '1.0.0-b24'],
  ['blueocean-pipeline-api-impl', '1.0.0-b24'],
  ['blueocean-rest-impl', '1.0.0-b24'],
  ['blueocean-rest', '1.0.0-b24'],
  ['blueocean-web', '1.0.0-b24'],
  ['favorite', '2.0.4'],
  ['jackson2-api', '2.7.3'],
  ['metrics', '3.1.2.9'],
  ['pubsub-light', '1.7'],
  ['sse-gateway', '1.15'],
  ['variant', '1.1']
]

# Jenkins installation urls
default['pw_jenkins2']['master']['install_method'] = 'download_deb'
default['pw_jenkins2']['master']['mirror'] = 'http://updates.jenkins-ci.org/download/plugins/'
default['pw_jenkins2']['master']['updatecenter'] = 'http://updates.jenkins-ci.org/update-center.json'
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
