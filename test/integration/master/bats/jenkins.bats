#!/usr/bin/env bats

@test "compare plugin list" {
  P_REAL=$(mktemp /tmp/plugins.real.XXXXXXXXXX) || { echo "Failed to create temp file"; exit 1; }
  P_EXP=$(mktemp /tmp/plugins.expected.XXXXXXXXXX) || { echo "Failed to create temp file"; exit 1; }

  run bash -c "java -jar /usr/local/lib/jenkins/jenkins-cli.jar -s http://localhost:8080/jenkins/ list-plugins | sort | sed -r 's;\s{1,}; ;g; s; \([0-9.]{1,}\)$;;g; s;^([a-zA-Z0-9-]{1,}) .* ([0-9a-fgit\.\+-]{1,})$;\1=\2;'"
  [ "$status" -eq 0 ]
  echo "$output" > $P_REAL

  cat <<EOF > $P_EXP
ansicolor=0.4.1
ant=1.2
antisamy-markup-formatter=1.1
build-flow-plugin=0.18
build-name-setter=1.3
build-pipeline-plugin=1.4.8
claim=2.7
conditional-buildstep=1.3.3
copyartifact=1.36
credentials=1.23
cvs=2.12
dashboardintegration=394+gitdee22fe
dashboard-view=2.9.6
emotional-jenkins-plugin=1.2
envinject=1.92.1
external-monitor-job=1.4
git-client=1.19.0
git=2.4.0
greenballs=1.14
groovy-postbuild=2.2.1
jacoco=1.0.19
javadoc=1.3
jenkinswalldisplay=0.6.27
jobConfigHistory=2.12
join=1.16
jquery=1.11.2-0
junit=1.2-beta-4
ldap=1.11
locale=1.2
m2release=0.14.0
mailer=1.15
mapdb-api=1.0.1.0
matrix-auth=1.2
matrix-project=1.6
maven-info=0.2.0
maven-plugin=2.12
multiple-scms=0.5
pam-auth=1.2
parameterized-trigger=2.29
performance=1.13
postbuild-task=1.8
preSCMbuildstep=0.3
PrioritySorter=3.4
rebuild=1.25
repository=1.2
run-condition=1.0
scm-api=0.2
scm-sync-configuration=0.0.8
script-security=1.15
ssh-credentials=1.11
ssh-slaves=1.10
subversion=2.5.3
swarm=2.0
token-macro=1.10
translation=1.12
windows-slaves=1.1
xvfb=1.0.16
EOF
diff -u $P_REAL $P_EXP
EXIT_CODE=$?

rm $P_REAL
rm $P_EXP

[[ $EXIT_CODE -eq 0 ]]

}

@test "check update-center is set to http://mirrors.jenkins-ci.org/updates/" {
  run "curl --silent http://localhost:8080/jenkins/pluginManager/advanced | grep '<input name=\"site\" value=\"http://mirrors.jenkins-ci.org/updates/\"'"
}

@test "check number of plugins" {
   run bash -c "java -jar /usr/local/lib/jenkins/jenkins-cli.jar -s http://localhost:8080/jenkins/ list-plugins | wc -l"
   echo "$output"
  [ "$status" -eq 0 ]
  [ "$output" = "57" ]
}
