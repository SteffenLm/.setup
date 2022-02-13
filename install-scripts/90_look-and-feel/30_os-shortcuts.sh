#!/bin/bash
export app_name="OS Shortcuts"

function is_app_already_installed() {
    return 0
}

function install_app() {
    setShortcut '0' 'Nautilus' 'nautilus' '<Super>e'
}

function setShortcut() { 
    id="$1"
    name="$2"
    command="$3"
    shortcut="$4"

    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$id/']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$id/ name "$name"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$id/ command "$command"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$id/ binding "$shortcut"
}
