#!/bin/bash
export app_name=".aliases"

function is_app_already_installed() {
    if [ -f "$USER_HOME/.aliases" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    touch "$USER_HOME/.aliases"
    echo 'source ~/.aliases' >> "$USER_HOME/.zshrc"

    echo 'alias glg="git lg"' >> "$USER_HOME/.aliases"
    echo 'alias gca="git commit --amand"' >> "$USER_HOME/.aliases"
    echo 'alias gcan="git commit --amand --no-edit"' >> "$USER_HOME/.aliases"
    return 0;
}