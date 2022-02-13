#!/bin/bash
export app_name="Fonts"


fonts=('fonts-roboto' 'fonts-firacode')

function is_app_already_installed() {
    for font in "${fonts[@]}"; do
        dpkg -s "$font"
        if [ "$?" -eq 1 ]; then
            return 0
        fi
    done
    return 1
}

function install_app() {
    for font in "${fonts[@]}"; do
        sudo apt install -y "$font"
    done
}