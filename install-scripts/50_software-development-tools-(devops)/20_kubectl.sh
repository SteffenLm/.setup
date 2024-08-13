#!/bin/bash
export app_name="kubectl"

function is_app_already_installed() {
    if ! command -v kubectl &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    # Copied from https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
    # prepare
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

    # add repo
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring

    # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

    # install
    sudo apt-get update -y
    sudo apt-get install -y kubectl
}
