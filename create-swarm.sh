#!/bin/bash -ex

source config.sh

docker swarm init --advertise-addr $(hostname -i)

docker network create -d overlay ${SWARM_NETWORK}
