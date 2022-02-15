#!/bin/bash
export app_name="nnn"

function is_app_already_installed() {
    if ! command -v nnn &> /dev/null ; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt-get install -y nnn
    # TODO: set alias as ll="nnn -deo -T v"
}