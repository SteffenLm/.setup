#!/bin/bash

# TODO:
#   - writing logs to file

# constants
BOLD="\033[1;37m" 

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED='\033[0;31m'

NC='\033[0m' # No Color

ERASE_LINE='\r\033[K'

# helpers
function printInstallationStarted() {
    echo -n "[ ] installing $1..."
}

function printAlreadyInstalled() {
   echo -e "$ERASE_LINE[${YELLOW}✔${NC}] installed $1"
}

function printInstallationResult() {
    if [ $? == 0 ]; then
        echo -e "$ERASE_LINE[${GREEN}✔${NC}] installed $1"
    else 
        echo -e "$ERASE_LINE[${RED}✘${NC}] failed to install $1"
    fi
}

function TitleCaseConverter() {
    title=$1
    title=${title//-/ }
    sed 's/.*/\L&/; s/[a-z]*/\u&/g' <<< "$title"    
}

# get script dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
BASEDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
INSTALL_SCRIPTS_DIR="$BASEDIR/install-scripts"

# get user home dir
USER_HOME=$(eval echo "~$different_user")
TMP_DIR="$BASEDIR/tmp"
mkdir "$TMP_DIR"

# get root privilidges
sudo echo ""

for app_category_dir in $(find $INSTALL_SCRIPTS_DIR -mindepth 1 -maxdepth 1 -type d | sort); do
    IFS='/' read -ra path <<< "$app_category_dir"
    app_category_dir_name=${path[-1]}

    IFS='_' read -ra name_parts <<< "$app_category_dir_name"
    app_category_name="${name_parts[-1]}"
    app_category_name="$(TitleCaseConverter "$app_category_name")"

    # install all apps inside current category
    echo -e "$BOLD---------   ${app_category_name}   ---------$NC"
    for install_script_path in $(find "$app_category_dir" -mindepth 1 -maxdepth 1 -type f | sort); do
        source "$install_script_path"

        printInstallationStarted "$app_name"

        ## check if already installed
        is_app_already_installed &> /dev/null
        if [[ $? == 1 ]]
        then
            ## already installed
            printAlreadyInstalled "$app_name"
        else
            ## install app
            install_app &> /dev/null
            printInstallationResult "$app_name"
        fi
    done

    echo ""
done

rm -rf "$TMP_DIR"