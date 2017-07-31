#!/bin/bash -ex

source config.sh

docker service create                   \
  --network ${SWARM_NETWORK}            \
  --replicas 1                          \
  --name ldap-service                   \
  --env SLAPD_PASSWORD=${LDAP_ADMIN_PW} \
  --env SLAPD_DOMAIN=${LDAP_DOMAIN}     \
  --publish 389:389                     \
  --mount type=bind,readonly=true,source=${SWARM_SHARE}/ldap-prepopulate,destination=/etc/ldap.dist/prepopulate \
  --mount type=bind,readonly=false,source=${SWARM_SHARE}/ldap-config,destination=/etc/ldap \
  --mount type=bind,readonly=false,source=${SWARM_SHARE}/ldap-data,destination=/var/lib/ldap \
  ldap
