#!/bin/bash -ex

./create-ldap.sh
./add-ldap-user.sh
./create-gerrit.sh
./create-jenkins.sh
