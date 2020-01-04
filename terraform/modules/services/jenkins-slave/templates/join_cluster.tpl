#!/bin/bash

JENKINS_URL="${jenkins_url}"
JENKINS_USERNAME="${jenkins_username}"
JENKINS_PASSWORD="${jenkins_password}"
JENKINS_CREDENTIALS_ID="${jenkins_credentials_id}"
INSTANCE_NAME=$(curl -s 169.254.169.254/latest/meta-data/local-hostname)
INSTANCE_IP=$(curl -s 169.254.169.254/latest/meta-data/local-ipv4)

curl -v -u $JENKINS_USERNAME:$JENKINS_PASSWORD -d 'script=
import hudson.model.Node.Mode
import hudson.slaves.*
import jenkins.model.Jenkins
import hudson.plugins.sshslaves.verifiers.NonVerifyingKeyVerificationStrategy
import hudson.plugins.sshslaves.SSHLauncher
DumbSlave slaveNode = new DumbSlave("'$INSTANCE_NAME'",
"'$INSTANCE_NAME'",
"/var/lib/jenkins/",
"3",
Mode.NORMAL,
"slaves",
new SSHLauncher("'$INSTANCE_IP'", 22, "'$JENKINS_CREDENTIALS_ID'", "", "", "", "", 60, 3, 15, new NonVerifyingKeyVerificationStrategy()),
RetentionStrategy.INSTANCE)

Jenkins.instance.addNode(slaveNode)
' $JENKINS_URL/script