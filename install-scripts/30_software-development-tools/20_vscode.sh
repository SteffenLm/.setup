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
    cd "$TMP_DIR" || exit
    wget -O vs-code.deb https://go.microsoft.com/fwlink/?LinkID=760868
    sudo apt install -y ./vs-code.deb

    # install plugins
    code --install-extension Angular.ng-template
    code --install-extension eamodio.gitlens
    code --install-extension ecmel.vscode-html-css
    code --install-extension k--kato.intellij-idea-keybindings
    code --install-extension timonwong.shellcheck
    code --install-extension codemooseus.vscode-devtools-for-chrome
    code --install-extension yzhang.markdown-all-in-one
}