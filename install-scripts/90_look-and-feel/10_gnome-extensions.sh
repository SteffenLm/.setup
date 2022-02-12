#!/bin/bash
export app_name="Gnome Extensions"

function is_app_already_installed() {
    if ! command -v gnome-tweaks &> /dev/null; then
        return 0
    fi

    # TODO: check if each extension is installed
    return 0
}

function install_app() {
    return 1; # TODO

    # install tweaks
    sudo apt update -y
    sudo apt install -y gnome-tweaks

    # get gnome shell version
    shellVersion=$(gnome-shell --version)
    shellVersion=${shellVersion:12:4}
    echo "Version: $shellVersion"

    cd "$TMP_DIR" || exit

    # install extension:
    extensionVersion=40 # TODO: find out using shell version
    wget -o user-theme.zip "https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v$extensionVersion.shell-extension.zip"
    extensionId=$(unzip -c user-theme.zip metadata.json | grep uuid | cut -d \" -f4)
    mkdir -p "$USER_HOME/.local/share/gnome-shell/extensions/$extensionId"
    unzip -q user-theme.zip -d "$USER_HOME/.local/share/gnome-shell/extensions/$extensionId/"
    gnome-shell-extension-tool -e "$extensionId"
}