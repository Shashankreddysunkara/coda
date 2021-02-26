#!/usr/bin/env bash

######## UPDATED SCRIPT ########
mkdir -p /home/ubuntu/sunny/sunny_jenkins_agent_ubuntu_container_var_jenkins_home_volume;
mkdir -p /home/ubuntu/sunny/sunny_jenkins_log_volume;

sudo docker build --no-cache -t jenkins-agent-ubuntu -f /home/ubuntu/sunny/workspace/$JOB_NAME/images/agent-ubuntu/Dockerfile .;
