#!/bin/bash
export app_name="JetBrains Toolbox"

function is_app_already_installed() {
    if [ -d "$USER_HOME/.local/share/JetBrains/Toolbox" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    cd "$TMP_DIR" || exit;
    wget -O jetbrains-toolbox.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.22.10970.tar.gz"
    tar -xf jetbrains-toolbox.tar.gz
    rm jetbrains-toolbox.tar.gz

    mv jetbrains-toolbox* jetbrains-toolbox
    ./jetbrains-toolbox/jetbrains-toolbox
}
