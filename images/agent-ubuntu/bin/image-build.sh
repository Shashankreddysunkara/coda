#!/usr/bin/env bash

docker build --no-cache -t jenkins-agent-ubuntu -f ~/coda/images/agent-ubuntu/bin/Dockerfile .;
