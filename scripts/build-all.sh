#!/bin/bash

docker build \
  --target env-fullnode \
  -t anax32/bitcoind:latest \
  -t anax32/bitcoind:v22.0 \
  --build-arg BITCOIN_CORE_TAG=v22.0 \
  --build-arg BOOST_VERSION=1.74 \
  --build-arg LIBEVENT_VERSION=2.1-7 \
  .
