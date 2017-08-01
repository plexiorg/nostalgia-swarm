#!/bin/bash -ex

source config.sh

ldapadd -x -w "${LDAP_ADMIN_PW}" -D cn=admin,dc=ldap,dc=example,dc=org -f ${SWARM_SHARE}/ldap-prepopulate/corny.ldif -H ldap://$(hostname -i):389
ldappasswd -s 'voravora' -w "${LDAP_ADMIN_PW}" -D cn=admin,dc=ldap,dc=example,dc=org -H ldap://$(hostname -i):389 -x uid=corny,dc=ldap,dc=example,dc=org
#ldapsearch -x -w "${LDAP_ADMIN_PW}" -D cn=admin,dc=ldap,dc=example,dc=org -b dc=ldap,dc=example,dc=org -LLL \
#  -H ldap://$(hostname -i):389
