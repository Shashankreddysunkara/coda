#!/usr/bin/env bash

exit_code=0;

mkdir -p keys;
mkdir -p sample;

cp ~/coda/settings/keys/jenkins.* ./keys &&\
    cp ~/coda/images/master/src/init.sh ./sample &&\
    docker build --no-cache -t jenkins-master -f ~/coda/images/master/Dockerfile ~/coda/.;
if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

rm -r ./keys;
rm -r ./sample;

exit $((exit_code));
