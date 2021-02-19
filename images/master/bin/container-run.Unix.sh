#!/usr/bin/env bash
#
#exit_code=0;
#
#docker run \
#    -d \
#    --name jenkins-master \
#    -p 8080:8080 \
#    -p 50000:50000 \
#    -v $(which docker):/usr/bin/docker \
#    -v /var/run/docker.sock:/var/run/docker.sock \
#    -v /root/workspace \
#    jenkins-master &&\
#
#if [[ "${?}" != 0 ]]; then
#    exit_code=1;
#fi;
#
#exit $((exit_code));
#
#sudo docker logs -f jenkins-master;

exit_code=0;

docker volume create jenkins-data
docker volume create jenkins-log
docker volume ls
docker run \
    -d \
    --name jenkins-master \
    -p 8080:8080 \
    -p 50000:50000 \
    -v $(which docker):/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /root:/root/workspace \
    --mount source=jenkins-log,target=/var/log/jenkins \
    --mount source=jenkins-data,target=/var/jenkins_home \
    jenkins-master &&\
    docker logs -f jenkins-master;

if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

exit $((exit_code));
