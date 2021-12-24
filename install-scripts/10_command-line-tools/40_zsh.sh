#!/bin/bash
export app_name="zsh"

function is_app_already_installed() {
    if ! command -v zsh &> /dev/null ; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt install -y zsh
    
    # TODO: Set zsh as default shell
    # ln -sf "$DIR/bashrc" ~/.bashrc
}