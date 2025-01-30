#!/bin/bash
cd
sudo apt update
sudo apt install libczmq-dev libzmq3-dev libsodium-dev pkg-config
pkg-config --modversion libczmq
sudo rm -rf /usr/local/go
wget https://golang.org/dl/go1.20.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xvzf go1.20.6.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile
go clean -cache
go clean -modcache
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
rm -rf ~/verification-layer-tester
cd;git clone https://github.com/Layer-Edge/verification-layer-tester.git
cd verification-layer-tester/
./build.sh
./run.sh
