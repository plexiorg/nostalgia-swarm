#!/bin/bash -ex

source config.sh

docker service create        \
    --network ${SWARM_NETWORK} \
    --replicas 1               \
    --name jenkins-service     \
    --publish 8081:8080        \
    --publish 50000:50000      \
    --mount type=bind,readonly=false,source=${SWARM_SHARE}/jenkins,destination=/var/jenkins_home \
    jenkins
