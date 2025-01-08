#!/bin/bash

sudo apt-get install xorg
sudo apt-get install libx11-6
sudo apt-get install xvfb
xvfb-run openledger-node --no-sandbox