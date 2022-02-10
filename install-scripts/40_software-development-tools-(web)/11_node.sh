#!/bin/bash
export app_name="node"

function is_app_already_installed() {
    if ! command -v node &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    nvm install --lts
}