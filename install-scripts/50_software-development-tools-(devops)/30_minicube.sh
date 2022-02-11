#!/bin/bash
export app_name="Minikube"

function is_app_already_installed() {
    if ! command -v minikube &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    # prepare
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install -y apt-transport-https

    # install virtual box
    echo virtualbox-ext-pack virtualbox-ext-pack/license select true | sudo debconf-set-selections
    sudo apt install -y virtualbox virtualbox-ext-pack # TODO: make install work with secure boot

    # download minikube
    cd "$TMP_DIR" || exit
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

    # install minikube
    sudo cp minikube-linux-amd64 /usr/local/bin/minikube
    sudo chmod 755 /usr/local/bin/minikube
}