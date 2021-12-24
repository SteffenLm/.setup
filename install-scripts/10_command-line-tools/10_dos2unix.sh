#!/bin/bash
export app_name="dos2unix"

function is_app_already_installed() {
    if ! command -v dos2unix &> /dev/null
    then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt install -y dos2unix
}