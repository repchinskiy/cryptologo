#!/bin/bash

# Цвета текста
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # Нет цвета (сброс цвета)

IDENTIFIER=$1
PIN=$2

# Проверка наличия curl и установка, если не установлен
if ! command -v curl &> /dev/null; then
    sudo apt update
    sudo apt install curl -y
fi
sleep 1
        sudo apt update && sudo apt upgrade -y

        # Проверка архитектуры системы и выбор подходящего клиента
        echo -e "${BLUE}Проверяем архитектуру системы...${NC}"
        ARCH=$(uname -m)
        if [[ "$ARCH" == "x86_64" ]]; then
            CLIENT_URL="https://cdn.app.multiple.cc/client/linux/x64/multipleforlinux.tar"
        elif [[ "$ARCH" == "aarch64" ]]; then
            CLIENT_URL="https://cdn.app.multiple.cc/client/linux/arm64/multipleforlinux.tar"
        else
            echo -e "${RED}Неподдерживаемая архитектура системы: $ARCH${NC}"
            exit 1
        fi

        # Скачиваем клиент
        echo -e "${BLUE}Скачиваем клиент с $CLIENT_URL...${NC}"
        wget $CLIENT_URL -O multipleforlinux.tar

        # Распаковываем архив
        echo -e "${BLUE}Распаковка файлов...${NC}"
        tar -xvf multipleforlinux.tar

        # Переход в папку клиента
        cd multipleforlinux

        # Выдача разрешений на выполнение
        echo -e "${BLUE}Выдача разрешений...${NC}"
        chmod +x ./multiple-cli
        chmod +x ./multiple-node

        # Добавление директории в системный PATH
        echo -e "${BLUE}Добавляем директорию в системный PATH...${NC}"
        echo "PATH=\$PATH:$(pwd)" >> ~/.bash_profile
        source ~/.bash_profile

        # Запуск ноды
        echo -e "${BLUE}Запускаем multiple-node...${NC}"
        nohup ./multiple-node > output.log 2>&1 &

        # Ввод Account ID и PIN
#        echo -e "${YELLOW}Введите ваш Account ID:${NC}"
#        read IDENTIFIER
#        echo -e "${YELLOW}Установите ваш PIN:${NC}"
#        read PIN

        # Привязка аккаунта
        echo -e "${BLUE}Привязываем аккаунт с ID: $IDENTIFIER и PIN: $PIN...${NC}"
        ./multiple-cli bind --bandwidth-download 100 --identifier $IDENTIFIER --pin $PIN --storage 200 --bandwidth-upload 100

        # Заключительный вывод
        echo "cd ~/multipleforlinux && ./multiple-cli status"
        sleep 2
        cd ~/multipleforlinux && ./multiple-cli status

