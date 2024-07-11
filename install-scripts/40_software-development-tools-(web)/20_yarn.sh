#!/bin/bash
export app_name="yarn"

function is_app_already_installed() {
    if ! command -v yarn &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo npm install -g corepack
    sudo corepack enable
    corepack prepare yarn@stable --active 
}