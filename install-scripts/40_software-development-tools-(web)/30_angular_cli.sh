#!/bin/bash
export app_name="Angular CLI"

function is_app_already_installed() {
    if ! command -v ng &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    npm install -g @angular/cli
    ng config -g cli.packageManager yarn
}