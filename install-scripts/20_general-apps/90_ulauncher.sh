#!/bin/bash
export app_name="ULauncher"

function is_app_already_installed() {
    if ! command -v ulauncher &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt-add-repository -y ppa:agornostal/ulauncher
    sudo apt update
    sudo apt install -y ulauncher

    ulauncher &
    ulauncher-toggle

    # adapt config
    settings=$(cat "$USER_HOME/.config/ulauncher/settings.json")
    settings=$(echo "$settings" | jq '.["theme-name"] = "dark"')
    settings=$(echo "$settings" | jq '.["hotkey-show-app"] = "<Alt>space"')
    echo "$settings" > "$USER_HOME/.config/ulauncher/settings.json"
}