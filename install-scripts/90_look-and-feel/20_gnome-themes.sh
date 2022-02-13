#!/bin/bash
export app_name="Gnome Themes"

function is_app_already_installed() {
    if [ -d "$USER_HOME/.themes/WhiteSur-dark-solid" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    cd "$TMP_DIR" || return 1;

    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
    cd "WhiteSur-gtk-theme" || return 1;
    ./install.sh -c dark -o solid -t default -s 280 -i ubuntu

    gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-dark-solid'
    # gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-dark-solid'
}