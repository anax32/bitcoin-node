# Bitcoin Fullnode from source

Builds a docker image of the bitcoin core daemon from the github mirror:
https://github.com/bitcoin/bitcoin

Build contains:
+ wallet
+ zmq
+ transaction db

The configuration file is built from environment variables prior to running `bitcoind`.

See `./config/bitcoind-env.conf` for details of which variables are supported.

# Usage

Build docker image as a multi-stage build.

+ first stage sets up the build environment,
+ second stage clones the repo and does the build,
+ third stage copies the binaries to a container with minium dependencies to run,
+ fourth stage sets the `envsubst` conf file to allow configuration with environment variables.

## Note on dependencies

`debian bullseye (11)` and `debian buster (10)` made different versions of
`libevent*` and `libboost*` available in package repositories: these variations
are captured in the `build-args` `BOOST_VERSION` and `LIBEVENT_VERSION` if you
wish the change the default debian base image.

# Build

Use this build script to cache the build environment:
```bash
docker build \
  -t anax32/bitcoind:latest \
  -t anax32/bitcoind:v22.0 \
  --build-arg BITCOIN_CORE_TAG=v22.0 \
  --build-arg BOOST_VERSION=1.74 \
  --build-arg LIBEVENT_VERSION=2.1-7 \
  .
```

build with `--target fullnode` to use a standard config file (examples in `./config/`).

config files can be created at: https://jlopp.github.io/bitcoin-core-config-generator/

Default config held in the container is pulled from the [bitcoin github repo](https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/examples/bitcoin.conf) in the `Dockerfile`.

# Run

Run docker image by creating two directories `./data` and `./config` to
store block data and config outside the container.

```bash
docker run \
  -d \
  --rm \
  --log-opt max-size=5m \
  --log-opt max-file=5 \
  --name btc-node \
  anax32/bitcoind
```

block chain and wallet data is stored in the container `/block-data` directory.

## Environment variable configuration

example regtest node:
```
docker run \
  -d \
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
  -p 8332:8332 \
  --name btc-node \
  anax32/bitcoind
```

# Disclaimer

You are responsible for your actions.
