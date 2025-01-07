#!/bin/bash

sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
ufw allow 8000;ufw allow 5555;ufw allow 443;ufw allow 8080
apt install unzip
. <(wget -qO- https://raw.githubusercontent.com/g7AzaZLO/server_primary_setting/refs/heads/main/server_primary_setting)
wget https://cdn.openledger.xyz/openledger-node-1.0.0-linux.zip
unzip openledger-node-1.0.0-linux.zip
sudo dpkg -i openledger-node-1.0.0.deb
sudo apt-get install -f
sudo apt-get install desktop-file-utils
sudo dpkg --configure -a
sudo apt-get install libgbm1
#sudo apt-get install libasound2
sudo apt-get install libasound2t64
touch ~/.Xauthority
#sudo nano /etc/ssh/sshd_config
#X11Forwarding yes
#X11DisplayOffset 10
#X11UseLocalhost yes
sed -i 's/#X11Forwarding/X11Forwarding/g' /etc/ssh/sshd_config
sed -i 's/#X11DisplayOffset/X11DisplayOffset/g' /etc/ssh/sshd_config
sed -i 's/#X11UseLocalhost/X11UseLocalhost/g' /etc/ssh/sshd_config
sudo systemctl restart ssh
#sudo systemctl start ssh
openledger-node --no-sandbox