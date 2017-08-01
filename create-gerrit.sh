#!/bin/bash -ex

source config.sh

docker service create                                       \
    --network ${SWARM_NETWORK}                                \
    --replicas 1                                              \
    --name gerrit-service                                     \
    --publish 8081:8080                                       \
    --publish 29418:29418                                     \
    --env AUTH_TYPE=LDAP                                      \
    --env LDAP_SERVER=ldap://ldap-service:389                 \
    --env "LDAP_ACCOUNTBASE=${GERRIT_LDAP_ACCOUNTBASE}"       \
    --env "LDAP_ACCOUNTPATTERN=${GERRIT_LDAP_ACCOUNTPATTERN}" \
    --mount type=bind,readonly=false,source=${SWARM_SHARE}/gerrit,destination=/var/gerrit/review_site \
    gerrit

