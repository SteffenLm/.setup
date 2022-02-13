#!/bin/bash
export app_name="ULauncher"

function is_app_already_installed() {
    if ! command -v ulauncher &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt-add-repository ppa:agornostal/ulauncher
    sudo apt update
    sudo apt install -y ulauncher

    # TODO:
    #   - set shortcut to <Alt>+<Space>
}