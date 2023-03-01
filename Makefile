RPC_USERNAME=my
RPC_PASSWORD=mypassword1

build:
	docker build \
	--target env-fullnode \
	-t anax32/bitcoind:latest \
	-t anax32/bitcoind:v24.0.1 \
	--build-arg BITCOIN_CORE_TAG=v24.0.1 \
	--build-arg BOOST_VERSION=1.74 \
	--build-arg LIBEVENT_VERSION=2.1-7 \
	.

run-reg-test:
	docker run \
	-d \
	--rm \
	--log-opt max-size=5m \
	--log-opt max-file=5 \
	-e BITCOIND_TESTNET=0 \
	-e BITCOIND_REGTEST=1 \
	-e BITCOIND_PRINTTOCONSOLE=1 \
	-e BITCOIND_SERVER=1 \
	-e BITCOIND_RPCUSER=${RPC_USERNAME} \
	-e BITCOIND_RPCPASSWORD=${RPC_PASSWORD} \
	-e BITCOIND_RPCALLOWIP=0.0.0.0/0 \
        -e BITCOIND_RPCPORT="8332" \
	-e BITCOIND_COINSTATSINDEX=1 \
	-e BITCOIND_TXINDEX=1 \
	-v $(shell pwd)/data:/block-data \
	-v $(shell pwd)/config:/config \
	-p 8332:8332 \
	--name btc-reg-node \
	anax32/bitcoind

	docker logs -f btc-reg-node

stop-reg-test:
	docker stop btc-reg-node

mine-reg-test:
