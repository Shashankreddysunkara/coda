#!/usr/bin/env bash

exit_code=0;

mkdir -p keys;

cp /mnt/c/Users/sunny/Documents/GitHub/coda/settings/keys/jenkins.application.id_rsa ./keys &&\
    cp /mnt/c/Users/sunny/Documents/GitHub/coda/settings/keys/jenkins.application.id_rsa.pub ./keys &&\
    cp /mnt/c/Users/sunny/Documents/GitHub/coda/settings/keys/jenkins.config.id_rsa ./keys &&\
    cp /mnt/c/Users/sunny/Documents/GitHub/coda/settings/keys/jenkins.config.id_rsa.pub ./keys &&\
    docker build --no-cache -t jenkins-master .;
if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

rm -r ./keys;

exit $((exit_code));
