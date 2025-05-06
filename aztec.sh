#!/bin/bash
set -e

# Создание директории
mkdir -p aztek && cd aztek

# Ввод переменных
#read -p "Введите ваш Ethereum приватный ключ EVM: " PRIVATE_KEY
#read -p "Введите ваш публичный адрес EVM: " PUBLIC_ADDRESS
#read -p "Введите Eth Sepolia RPC URL: " RPC_URL
#read -p "Введите BEACON Sepolia URL : " BEACON_URL
#read -p "Введите ваш внешний IP (например, 45.13.56.1): " SERVER_IP
PRIVATE_KEY=$1
PUBLIC_ADDRESS=$2
RPC_URL=$3
BEACON_URL=$4
SERVER_IP=$5

# Создание .env
cat <<EOF > .env
VALIDATOR_PRIVATE_KEY=$PRIVATE_KEY
PUBLIC_ADDRESS=$PUBLIC_ADDRESS
RPC_URL=$RPC_URL
BEACON_URL=$BEACON_URL
SERVER_IP=$SERVER_IP
EOF

# Создание docker-compose.yml
cat <<EOF > docker-compose.yml
version: "3.8"

services:
  aztec-node:
    image: aztecprotocol/aztec:0.85.0-alpha-testnet.5
    container_name: aztec-node
    environment:
      ETHEREUM_HOSTS: "\${RPC_URL}"
      L1_CONSENSUS_HOST_URLS: "\${BEACON_URL}"
      DATA_DIRECTORY: /data
      VALIDATOR_PRIVATE_KEY: "\${VALIDATOR_PRIVATE_KEY}"
      P2P_IP: "\${SERVER_IP}"
      LOG_LEVEL: debug
    entrypoint: >
      sh -c 'node --no-warnings /usr/src/yarn-project/aztec/dest/bin/index.js start --network alpha-testnet --node --archiver --sequencer --sequencer.validatorPrivateKey \${VALIDATOR_PRIVATE_KEY} --sequencer.coinbase \${PUBLIC_ADDRESS} --p2p.p2pIp \${SERVER_IP}'
    ports:
      - 40400:40400/tcp
      - 40400:40400/udp
      - 8080:8080
    volumes:
      - ./data:/data
    restart: unless-stopped
    network_mode: host
EOF

# Запуск и показ логов
docker compose up -d && docker logs -f aztec-node
