#!/bin/bash
export app_name="Visual Studio Code"

function is_app_already_installed() {
    if ! command -v code &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    cd "$TMP_DIR" || exit
    wget -O vs-code.deb https://go.microsoft.com/fwlink/?LinkID=760868
    sudo apt install -y ./vs-code.deb

    # TODO:
    #   - install plugins
}