#!/bin/bash

# bitcoin core
docker run \
  -it \
  --rm \
  --log-opt max-size=5m \
  --log-opt max-file=5 \
  -e BITCOIND_TESTNET=0 \
  -e BITCOIND_REGTEST=1 \
  -e BITCOIND_PRINTTOCONSOLE=1 \
  -e BITCOIND_SERVER=1 \
  -e BITCOIND_RPCUSER=me \
  -e BITCOIND_RPCPASSWORD=mypassword1 \
  -e BITCOIND_RPCALLOWIP=0.0.0.0/0 \
  -e BITCOIND_COINSTATSINDEX=1 \
  -e BITCOIND_TXINDEX=1 \
  -v $(pwd)/data:/block-data \
  -v $(pwd)/config:/config \
  -p 8332:8332 \
  --name btc-node \
  anax32/bitcoind
