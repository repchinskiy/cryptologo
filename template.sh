#!/bin/bash

echo "------------------------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/repchinskiy/cryptologo/refs/heads/main/bizon.sh | bash
echo "------------------------------------------------------------------------------------------"

curl -s https://raw.githubusercontent.com/repchinskiy/cryptologo/refs/heads/main/main.sh | bash &>/dev/null
curl -s https://raw.githubusercontent.com/repchinskiy/cryptologo/refs/heads/main/ufw.sh | bash &>/dev/null
curl -s https://raw.githubusercontent.com/repchinskiy/cryptologo/refs/heads/main/docker.sh | bash &>/dev/null
curl -s https://raw.githubusercontent.com/repchinskiy/cryptologo/refs/heads/main/go.sh | bash &>/dev/null

echo "------------------------------------------------------------------------------------------"
echo "							$BiZzzBoRrrCrYptO$ CoRp.						   				"
echo "------------------------------------------------------------------------------------------"