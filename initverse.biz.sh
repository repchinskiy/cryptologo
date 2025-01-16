#!/bin/bash

# Проверка наличия curl и установка, если не установлен
if ! command -v curl &> /dev/null; then
    sudo apt update
    sudo apt install curl -y
fi
sleep 1
            # Обновление и установка зависимостей
            sudo apt update -y
            sudo apt upgrade -y
            sudo apt install -y wget

            # Создаем папку и скачиваем бинарник
            mkdir -p $HOME/initverse
            cd $HOME/initverse
            wget https://github.com/Project-InitVerse/ini-miner/releases/download/v1.0.0/iniminer-linux-x64
            chmod +x iniminer-linux-x64
            cd

            WALLET=$1
            NODE_NAME=$2
            # Создаем файл .env и записываем данные
            echo "WALLET=$WALLET" > "$HOME/initverse/.env"
            echo "NODE_NAME=$NODE_NAME" >> "$HOME/initverse/.env"
            sleep 1

            # Определяем имя текущего пользователя и его домашнюю директорию
            USERNAME=$(whoami)
            HOME_DIR=$(eval echo ~$USERNAME)

            # Создание сервиса
            sudo bash -c "cat <<EOT > /etc/systemd/system/initverse.service
[Unit]
Description=InitVerse Miner Service
After=network.target

[Service]
User=$USERNAME
WorkingDirectory=$HOME_DIR/initverse
EnvironmentFile=$HOME_DIR/initverse/.env
ExecStart=/bin/bash -c 'source $HOME_DIR/initverse/.env && $HOME_DIR/initverse/iniminer-linux-x64 --pool stratum+tcp://${WALLET}.${NODE_NAME}@pool-core-testnet.inichain.com:32672 --cpu-devices 1 --cpu-devices 2'
Restart=on-failure
Environment=WALLET=\$WALLET NODE_NAME=\$NODE_NAME

[Install]
WantedBy=multi-user.target
EOT"

            # Запуск сервиса
            sudo systemctl daemon-reload
            sudo systemctl restart systemd-journald
            sleep 1
            sudo systemctl enable initverse
            sudo systemctl start initverse

            echo "sudo journalctl -fu initverse.service"
            sleep 2
            sudo journalctl -fu initverse.service