#!/bin/bash
export app_name="Chromium Browser"

function is_app_already_installed() {
    if ! command -v chromium-browser &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt install -y chromium-browser chromium-codecs-ffmpeg
}