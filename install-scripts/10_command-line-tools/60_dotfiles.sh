#!/bin/bash
export app_name=".dotfiles"

function is_app_already_installed() {
    if [ -d "$USER_HOME/.dotfiles" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    return 1; # TODO
}