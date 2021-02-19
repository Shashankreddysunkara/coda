#!/usr/bin/env bash

exit_code=0;

docker volume create jenkins-data
docker volume create jenkins-log
docker volume ls

docker run \
    -d \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --mount source=jenkins-log,target=/var/log/jenkins \
    --mount source=jenkins-data,target=/var/jenkins_home \
    --name jenkins-agent-ubuntu \
    jenkins-agent-ubuntu &&\
    sudo docker logs -f jenkins-agent-ubuntu;

if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

exit $((exit_code));