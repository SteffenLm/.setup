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
    wget -O jetbrains-toolbox.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.22.10970.tar.gz?_ga=2.149720694.1542304937.1644746805-1728814540.1639591165&_gl=1*92zwjp*_ga*MTcyODgxNDU0MC4xNjM5NTkxMTY1*_ga_V0XZL7QHEB*MTY0NDc0NjgwNC4zLjEuMTY0NDc0NzM0Mi41OQ.."
    extract jetbrains-toolbox.tar.gz
    rm jetbrains-toolbox.tar.gz

    mv jetbrains-toolbox* jetbrains-toolbox
    ./jetbrains-toolbox/jetbrains-toolbox
}