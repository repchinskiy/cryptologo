#!/bin/bash
version="v0.11.2"
curl -s https://raw.githubusercontent.com/DOUBLE-TOP/tools/main/doubletop.sh | bash
systemctl stop hemi
cd $HOME
wget https://github.com/hemilabs/heminetwork/releases/download/$version/heminetwork_"$version"_linux_amd64.tar.gz
tar -xvf heminetwork_"$version"_linux_amd64.tar.gz && rm heminetwork_"$version"_linux_amd64.tar.gz
mv -f $HOME/heminetwork_"$version"_linux_amd64/* $HOME/hemi
rm -rf $HOME/heminetwork_"$version"_linux_amd64
sudo systemctl daemon-reload
echo start hemi ... 
sudo systemctl start hemi
echo OK 
