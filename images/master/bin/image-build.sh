#!/usr/bin/env bash

exit_code=0;

mkdir -p keys;

cp ~/coda/settings/keys/jenkins.* ./keys &&\
    docker build --no-cache -t jenkins-master .;
if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

rm -r ./keys;

exit $((exit_code));
