#!/bin/bash
export app_name="Kubernetes"

function is_app_already_installed() {
    if ! command -v kubectl &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    echo "TODO"
}