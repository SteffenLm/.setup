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
    sudo -E add-apt-repository -y ppa:agornostal/ulauncher
    sudo apt update
    sudo apt install -y ulauncher

    ulauncher &

    # adapt config
    while [ ! -f "$USER_HOME/.config/ulauncher/settings.json" ]; do sleep 1; done
    settings=$(cat "$USER_HOME/.config/ulauncher/settings.json")
    settings=$(echo "$settings" | jq '.["theme-name"] = "dark"')
    settings=$(echo "$settings" | jq '.["hotkey-show-app"] = "<Alt>space"')
    settings=$(echo "$settings" | jq '.["show-indicator-icon"] = false')
    echo "$settings" > "$USER_HOME/.config/ulauncher/settings.json"

    sudo pkill ulauncher
    ulauncher &
    sleep 1
    ulauncher-toggle
    return 0
}
