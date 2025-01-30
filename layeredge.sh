#!/bin/bash
cd
sudo rm -rf /usr/local/go
wget https://golang.org/dl/go1.20.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xvzf go1.20.6.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile
go clean -cache
go clean -modcache
sudo apt-get install libczmq-dev
pkg-config --modversion libczmq
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
rm -rf ~/verification-layer-tester
cd;git clone https://github.com/Layer-Edge/verification-layer-tester.git
cd verification-layer-tester/
./build.sh
./run.sh

