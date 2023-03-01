#!/bin/bash

##
#
# example curl commands to interact with the json rpc server on localhost
#
# usage:
#  RPC_USERNAME=mu RPC_PASSWORD=mypassword1 ./regtest-chain-info-rest.sh
#
# NB: this uses the following commands:
#  + getblockchaininfo (https://bitcoincore.org/en/doc/24.0.0/rpc/blockchain/getblockchaininfo/)
#  + getblockcount (https://bitcoincore.org/en/doc/24.0.0/rpc/blockchain/getblockcount/)
#
##

RPCUSER=${RPC_USERNAME:-mu}
RPCPASS=${RPC_PASSWORD:-mypassword1}

# getblockchaininfo from btc-node
curl \
  -u $RPCUSER:$RPCPASS \
  --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getblockchaininfo", "params": []}' \
  -H 'content-type: text/plain;' \
  http://localhost:8332


# getblockcount from btc-node
curl \
  -u $RPCUSER:$RPCPASS \
  --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getblockcount", "params": []}' \
  -H 'content-type: text/plain;' \
  http://localhost:8332
