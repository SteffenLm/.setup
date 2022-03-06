#!/bin/bash
export app_name="Brave Browser"

function is_app_already_installed() {
    if ! command -v brave-browser &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt -y install apt-transport-https
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt -y update
    sudo apt -y install brave-browser
}