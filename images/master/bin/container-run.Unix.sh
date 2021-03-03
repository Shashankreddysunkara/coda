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

#docker volume create jenkins-data
#docker volume create jenkins-log
#docker volume ls
sudo docker run \
    -d \
    --name jenkins-master \
    -p 8081:8081 \
    -p 50000:50000 \
    -v $(which docker):/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/ubuntu/sunny/sunny_jenkins_master_log_volume:/var/log/jenkins \
    jenkins-master &&\

#    -v /root/sunny_jenkins:/root/jenkins \

     ###### UNCOMMENT BELOW to use root dir  ########
#    -v /root/sunny_jenkins:/var/log/jenkins \
     ##### UPDATED SCRIPT #########
#     -v /home/ubuntu/sunny/sunny_jenkins_log_volume:/var/log/jenkins \

#    --mount source=jenkins-log,target=/var/log/jenkins \
#    --mount source=jenkins-data,target=/root/jenkins/workspace \
#    jenkins-master &&\

if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

exit $((exit_code));
