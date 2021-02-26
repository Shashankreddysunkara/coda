#!/usr/bin/env bash

exit_code=0;

sudo docker volume ls

sudo docker run \
    -d \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/ubuntu/sunny/sunny_jenkins_agent_log_volume:/var/log/jenkins \
    -v /home/ubuntu/sunny/sunny_jenkins_agent_ubuntu_container_var_jenkins_home_volume:/var/jenkins_home \
    --name jenkins-agent-ubuntu \
    jenkins-agent-ubuntu &&\

      ###########  UNCOMMENT #########
#    --mount source=jenkins-log,target=/var/log/jenkins \

#    -v /home/ubuntu/sunny/sunny_jenkins_log_volume:/var/log/jenkins \

     ###########  UNCOMMENT #########
#    --mount source=jenkins-data,target=/var/jenkins_home \

#    -v /home/ubuntu/sunny/sunny_jenkins_agent_ubuntu_container_var_jenkins_home_volume:/var/jenkins_home \

#    --name jenkins-agent-ubuntu \
#    jenkins-agent-ubuntu &&\

if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

exit $((exit_code));