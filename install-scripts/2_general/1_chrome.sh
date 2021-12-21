#!/bin/bash
export app_name="Google Chrome"

function is_app_already_installed() {
    if ! command -v google-chrome &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    cd "$TMP_DIR" || exit
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
}