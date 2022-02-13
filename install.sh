#!/bin/bash

# Download scripts
wget https://github.com/ISchwarz23/.setup/archive/refs/heads/ubuntu.zip
sudo apt-get install -y unzip
unzip ubuntu.zip -d .setup
rm ubuntu.zip

# Run install-local.sh
./.setup/install-local.sh

# remove "ubuntu" folder
rm -rf .setup