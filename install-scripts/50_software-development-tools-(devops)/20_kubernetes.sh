#!/bin/bash
export app_name="Kubernetes"

function is_app_already_installed() {
    if ! command -v kubectl &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    # prepare
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates

    # add repo
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    # install
    sudo apt-get update -y
    sudo apt-get install -y kubectl
}