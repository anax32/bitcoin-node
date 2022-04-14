#!/bin/bash

##
#
# create a bitcoind conf file using environment variables and envsubst
#
##

export HOST_IP=$(hostname -i)

echo $HOST_IP

envsubst < config/bitcoind-env.conf > config/tmp.conf
