#!/usr/bin/env bash

exit_code=0;

chmod 777 /usr/local/bin/init.sh;

docker run \
    -d \
    --name jenkins-master \
    -p 8080:8080 \
    -p 50000:50000 \
    -v $(which docker):/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /root/workspace \
    jenkins-master &&\
    sudo docker logs -f jenkins-master;

if [[ "${?}" != 0 ]]; then
    exit_code=1;
fi;

exit $((exit_code));
