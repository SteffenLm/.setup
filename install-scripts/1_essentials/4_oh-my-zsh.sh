#!/bin/bash
app_name="oh-my-zsh"

function is_app_already_installed() {
    USER_HOME=$(eval echo "~$different_user")
    if [ -d "$USER_HOME/.oh-my-zsh" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    echo "TODO"
}