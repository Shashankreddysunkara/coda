#!/usr/bin/env bash

exit_code=0;

mkdir -p /home/ubuntu/sunny/workspace/$JOB_NAME/keys;
mkdir -p /home/ubuntu/sunny/workspace/$JOB_NAME/sample;
mkdir -p /home/ubuntu/sunny/sunny_jenkins_master_container_home_volume;
mkdir -p /home/ubuntu/sunny/sunny_jenkins_log_volume;

#cp ~/coda/settings/keys/jenkins.* ./keys &&\
#    cp ~/coda/images/master/src/init.sh ./sample &&\
#    docker build --no-cache -t jenkins-master -f ~/coda/images/master/Dockerfile ~/coda/.;

cp /home/ubuntu/.ssh/jenkins.* /home/ubuntu/sunny/workspace/$JOB_NAME/keys &&\
cp /home/ubuntu/sunny/workspace/$JOB_NAME/images/master/src/init.sh /home/ubuntu/sunny/workspace/$JOB_NAME/sample &&\

#docker build --no-cache -t jenkins-master -f /home/ubuntu/sunny/workspace/$JOB_NAME/images/master/Dockerfile ~/coda/.;
sudo docker build --no-cache -t jenkins-master -f /home/ubuntu/sunny/workspace/$JOB_NAME/images/master/Dockerfile /home/ubuntu/sunny/workspace/$JOB_NAME/.;
if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

rm -r /home/ubuntu/sunny/workspace/$JOB_NAME/keys;
rm -r /home/ubuntu/sunny/workspace/$JOB_NAME/sample;

exit $((exit_code));
