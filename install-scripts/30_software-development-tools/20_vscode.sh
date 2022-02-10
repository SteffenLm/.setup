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
    echo "TODO"
}