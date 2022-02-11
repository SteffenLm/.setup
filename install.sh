#!/bin/bash

# constants
BOLD="\033[1;37m" 

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED='\033[0;31m'

NC='\033[0m' # No Color

ERASE_LINE='\r\033[K'

# helpers
function printInstallationStarted() {
    echo -n "  [ ] $1..."
}

function printAlreadyInstalled() {
    echo -e "$ERASE_LINE  [${YELLOW}✔${NC}] $1"
}

function printInstallationResult() {
    if [ $? == 0 ]; then
        echo -e "$ERASE_LINE  [${GREEN}✔${NC}] $1"
    else 
        echo -e "$ERASE_LINE  [${RED}✘${NC}] $1"
    fi
}

function TitleCaseConverter() {
    title=$1
    title=${title//-/ }
    sed 's/.*/\L&/; s/[a-z]*/\u&/g' <<< "$title"    
}

function printCategoryTitle() {
    app_category_name="$(TitleCaseConverter "$1")"
    echo -e "\n$BOLD---------   ${app_category_name}   ---------$NC\n"
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
LOG_FILE="$BASEDIR/setup.log"
TMP_DIR="$BASEDIR/tmp"
mkdir "$TMP_DIR"

# get root privilidges
sudo echo ""

# create empty log file with timestamp
date > "$LOG_FILE"
printf "\n" >> "$LOG_FILE"

for app_category_dir in $(find $INSTALL_SCRIPTS_DIR -mindepth 1 -maxdepth 1 -type d | sort); do
    IFS='/' read -ra path <<< "$app_category_dir"
    app_category_dir_name=${path[-1]}

    IFS='_' read -ra name_parts <<< "$app_category_dir_name"

    # install all apps inside current category
    printCategoryTitle "${name_parts[-1]}"
    for install_script_path in $(find "$app_category_dir" -mindepth 1 -maxdepth 1 -type f | sort); do
        source "$install_script_path"

        printf "\n# Installing %s\n" "$app_name" >> "$LOG_FILE"
        printInstallationStarted "$app_name"

        ## check if already installed
        is_app_already_installed &>> "$LOG_FILE"
        if [[ $? == 1 ]]
        then
            ## already installed
            printf "already installed\n" >> "$LOG_FILE"
            printAlreadyInstalled "$app_name"
        else
            ## install app
            install_app &>> "$LOG_FILE"
            printInstallationResult "$app_name"
        fi
    done

    echo ""
done

rm -rf "$TMP_DIR"



# TODO:
#   - alternatives (script with same nummer)