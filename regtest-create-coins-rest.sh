#!/bin/bash

##
#
# example curl commands to interact with the json rpc server on localhost
#
# usage:
#  RPC_USERNAME=mu RPC_PASSWORD=mypassword1 ./regtest-create-coins-rest.sh
#
# NB: this uses the following commands:
#  + createwallet (fails if exists https://bitcoincore.org/en/doc/24.0.0/rpc/wallet/createwallet/)
#  + getnewaddress (https://bitcoincore.org/en/doc/24.0.0/rpc/wallet/getnewaddress/)
#  + generatetoaddress (only valid on regtest https://developer.bitcoin.org/reference/rpc/generatetoaddress.html)
#  + getbalance (https://bitcoincore.org/en/doc/24.0.0/rpc/wallet/getbalance/)
#
##

RPCUSER=${RPC_USERNAME:-me}
RPCPASS=${RPC_PASSWORD:-mypassword1}
RPC_SERVER=http://localhost:8332

# create a wallet
curl \
  -u $RPCUSER:$RPCPASS \
  --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "createwallet", "params": ["testwallet"]}' \
  -H 'content-type: text/plain;' \
  ${RPC_SERVER}

# create an address to mine into
R=$(curl \
  -u $RPCUSER:$RPCPASS \
  --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' \
  -H 'content-type: text/plain;' \
  ${RPC_SERVER})

ADDR=$(echo ${R} | jq .result )

echo ADDR=${ADDR}

# mine some blocks
curl \
  -u $RPCUSER:$RPCPASS \
  --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "generatetoaddress", "params": [101, '"${ADDR}"']}' \
  -H 'content-type: text/plain;' \
  ${RPC_SERVER}

# get the wallet balance
curl \
  -u $RPCUSER:$RPCPASS \
  --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getbalance", "params": []}' \
  -H 'content-type: text/plain;' \
  ${RPC_SERVER}
