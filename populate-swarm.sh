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
  ldap

sleep 5
#ldapadd -x -w "${LDAP_ADMIN_PW}" -D cn=admin,dc=ldap,dc=example,dc=org -f ldap-prepopulate/corny.ldif -H ldap://$(hostname -i):389
ldappasswd -s 'trextrex' -w "${LDAP_ADMIN_PW}" -D cn=admin,dc=ldap,dc=example,dc=org -H ldap://$(hostname -i):389 -x uid=corny,dc=ldap,dc=example,dc=org
#ldapsearch -x -w "${LDAP_ADMIN_PW}" -D cn=admin,dc=ldap,dc=example,dc=org -b dc=ldap,dc=example,dc=org -LLL \
#  -H ldap://$(hostname -i):389

docker service create                                       \
  --network ${SWARM_NETWORK}                                \
  --replicas 1                                              \
  --name gerrit-service                                     \
  --publish 8080:8080                                       \
  --publish 29418:29418                                     \
  --env AUTH_TYPE=LDAP                                      \
  --env LDAP_SERVER=ldap://ldap-service:389                 \
  --env "LDAP_ACCOUNTBASE=${GERRIT_LDAP_ACCOUNTBASE}"       \
  --env "LDAP_ACCOUNTPATTERN=${GERRIT_LDAP_ACCOUNTPATTERN}" \
  gerrit

docker service create        \
  --network ${SWARM_NETWORK} \
  --replicas 1               \
  --name jenkins-service     \
  --publish 8081:8080        \
  --publish 50000:50000      \
  jenkins
