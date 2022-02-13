#!/bin/bash

# Download scripts
wget https://github.com/ISchwarz23/.setup/archive/refs/heads/ubuntu.zip &> /dev/null
sudo apt-get install -y unzip &> /dev/null
unzip ubuntu.zip &> /dev/null
rm ubuntu.zip

# Run install-local.sh
./.setup-ubuntu/install-local.sh

# remove "ubuntu" folder
rm -rf .setup-ubuntu