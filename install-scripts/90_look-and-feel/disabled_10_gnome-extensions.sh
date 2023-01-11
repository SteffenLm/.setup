#!/bin/bash
export app_name="Gnome Extensions"

EXTENSIONS_TO_INSTALL=(
    "https://extensions.gnome.org/extension/19/user-themes/"
    "https://extensions.gnome.org/extension/3906/remove-app-menu/"
    "https://extensions.gnome.org/extension/4451/logo-menu/"
)
EXTENSIONS_TO_DISABLE=(
    "https://extensions.gnome.org/extension/1465/desktop-icons/"
    "https://extensions.gnome.org/extension/1301/ubuntu-appindicators/"
    "https://extensions.gnome.org/extension/1300/ubuntu-dock/"
)

function is_app_already_installed() {
    # check if tools are installed
    if ! command -v gnome-tweaks &> /dev/null; then
        return 0
    fi
    if ! command -v chrome-gnome-shell &> /dev/null; then
        return 0
    fi

    # check if extensions are installed
    for extensionPageUrl in "${EXTENSIONS_TO_INSTALL[@]}"; do
        if [ "$(isExtensionInstalled "$extensionPageUrl")" == "0" ]; then
            return 0
        fi
    done
    
    return 1
}

function install_app() {
    cd "$TMP_DIR" || exit

    # install tweaks
    sudo apt install -y gnome-tweaks chrome-gnome-shell

    # install extensions
    for extensionPageUrl in "${EXTENSIONS_TO_INSTALL[@]}"; do
        installExtension "$extensionPageUrl"
    done

    # disable extensions
    for extensionPageUrl in "${EXTENSIONS_TO_DISABLE[@]}"; do
        disableExtension "$extensionPageUrl"
    done

    # restart gnome
    killall -3 gnome-shell
}

function installExtension() {
    extensionPageUrl="$1"
    extensionPageContent=$(curl "$extensionPageUrl")

    # Get extension UUID
    extensionId=$(echo "$extensionPageContent" | grep data-uuid=\")
    extensionId=${extensionId:20:-1}

    # Abort if already installed
    if [ "$(isExtensionInstalledById "$extensionId")" == "1" ]; then
        return
    fi

    # Get mapping from shell version to extension versions
    versionMap=$(echo "$extensionPageContent" | grep data-versions=\")
    versionMap=${versionMap:24:-2}
    versionMap=${versionMap//&quot;/\"}

    # Get the installed shell version
    shellVersion=$(getShellVersion)

    # Get extension version for our shell version
    extensionVersion=$(echo "$versionMap" | jq .\""$shellVersion"\" | jq 'keys' | jq -r '.[-1]')

    # Aggregate download url
    encodedVersion=$(urlEncode "$extensionVersion")
    encodedUuid=$(urlEncode "$extensionId")
    extensionDownloadUrl="https://extensions.gnome.org/download-extension/$encodedUuid.shell-extension.zip?version_tag=$encodedVersion";

    # Download, install and enable extension
    wget -O "$extensionId.zip" "$extensionDownloadUrl"
    gnome-extensions install "$extensionId.zip"
    gnome-extensions enable "$extensionId"
}

function disableExtension() {
    extensionId="$1"
    gnome-extensions disable "$extensionId"
}

function isExtensionInstalled() {
    extensionPageUrl="$1"
    extensionPageContent=$(curl "$extensionPageUrl")

    # Get extension UUID
    extensionId=$(echo "$extensionPageContent" | grep data-uuid=\")
    extensionId=${extensionId:20:-1}

    result=$(isExtensionInstalledById "$extensionId")
    echo "$result"
    return "$result"
}

function isExtensionInstalledById() {
    extensionId="$1"

    # check if extension dir is present
    if [ -d "$USER_HOME/.local/share/gnome-shell/extensions/$extensionId" ]; then
        echo "1"
        return 1
    else
        echo "0"
        return 0
    fi
}

function getShellVersion() {
    shellVersion=$(gnome-shell --version)
    shellVersion=${shellVersion:12:4}
    echo "$shellVersion"
}

function urlEncode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
}

function showExtensionInstallHint() {
    zenity --info --title='Manual Step' --text "Firefox will start showing extensions. You need to set the switch to 'ON' and close firefox afterwards for each of them." --width=300
}

function showExtensionDisableHint() {
    zenity --info --title='Manual Step' --text "Firefox will start showing extensions. You need to set the switch to 'OFF' and close firefox afterwards for each of them." --width=300
}

function letUserEditExtension() {
    firefox -new-window "$1"
}
