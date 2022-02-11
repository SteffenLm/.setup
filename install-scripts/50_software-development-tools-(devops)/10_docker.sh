#!/bin/bash
export app_name="Docker"

function is_app_already_installed() {
    if ! command -v docker &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    # prepare
    sudo apt-get update -y 
    sudo apt-get install -y ca-certificates gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg -y --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # install
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}