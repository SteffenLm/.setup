#!/bin/bash
export app_name="Wallpapers"

function is_app_already_installed() {
    if [ -d "$USER_HOME/Pictures/Wallpapers" ]; then
        return 1
    fi
    return 0
}

function install_app() {
    mkdir -p "$USER_HOME/Pictures/Wallpapers"
    cd "$USER_HOME/Pictures/Wallpapers" || return 1

    # catalina
    wget -O catalina-night.jpg https://4kwallpapers.com/images/wallpapers/macos-catalina-mountains-island-night-cold-stock-5k-6016x6016-4022.jpg
    wget -O catalina-day.jpg https://4kwallpapers.com/images/wallpapers/macos-catalina-mountains-island-sunny-day-stock-5k-6016x6016-4013.jpg
    wget -O catalina-morning.jpg https://4kwallpapers.com/images/wallpapers/macos-catalina-mountains-island-morning-stock-5k-6016x6016-4015.jpg
    wget -O catalina-evening.jpg https://4kwallpapers.com/images/wallpapers/macos-catalina-mountains-island-evening-twilight-sunset-6016x6016-4009.jpg
    wget -O catalina-late-evening.jpg https://4kwallpapers.com/images/wallpapers/macos-catalina-mountains-island-daytime-stock-5k-6016x6016-188.jpg

    # set wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$USER_HOME/Pictures/Wallpapers/catalina-late-evening.jpg"
    echo "file://$USER_HOME/Pictures/Wallpapers/catalina-late-evening.jpg"
}