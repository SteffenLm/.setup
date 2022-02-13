#!/bin/bash

# Download scripts
wget https://github.com/ISchwarz23/.setup/archive/refs/heads/ubuntu.zip > /dev/null
sudo apt-get install -y unzip > /dev/null
unzip ubuntu.zip -d .setup > /dev/null
rm ubuntu.zip

# Run install-local.sh
./.setup/install-local.sh

# remove "ubuntu" folder
rm -rf .setup