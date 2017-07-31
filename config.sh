#!/bin/bash

SWARM_NETWORK="pi-swarm-net"
SWARM_SHARE="/mnt/data/"

LDAP_ADMIN_PW="voravora"
LDAP_DOMAIN="ldap.example.org"

GERRIT_LDAP_ACCOUNTBASE="dc=ldap,dc=example,dc=org"
GERRIT_LDAP_ACCOUNTPATTERN='(cn=${username})'
