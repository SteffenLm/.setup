#!/bin/bash
export app_name="oh-my-zsh"

function is_app_already_installed() {
    if [ -d "$USER_HOME/.oh-my-zsh" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    cd "$TMP_DIR" || exit
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sh install.sh
}