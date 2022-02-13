#!/bin/bash

# constants
BOLD="\033[1;37m" 

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED='\033[0;31m'
NC='\033[0m' # No Color

ERASE_LINE='\033[2K\r'
LINE_UP="\033[2A"


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

function resolve_app_name {
    source "$1"
    echo "$app_name"
}

function select_app {
    # show options
    echo "Select the app you prefer:" 1>&2
    app_names=()
    for script in "$@"; do
        app_names+=("$(resolve_app_name "$script")")
    done;
    select_option "${app_names[@]}" 1>&2
    local result=$?
    result=$((result+1))

    # erase printed lines
    count=${#app_names[@]}
    count=$((count+2))
    for _ in $(seq $count); do
        echo -e "$LINE_UP$ERASE_LINE" 1>&2
    done

    echo "${@:$result:1}"
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
export USER_HOME=$(eval echo "~$different_user")
export LOG_FILE="$BASEDIR/setup.log"
export TMP_DIR="$BASEDIR/tmp"
mkdir -p "$TMP_DIR"

# load select opts function
source "$BASEDIR/select-opts.sh"

# get root privilidges
sudo echo ""

# create empty log file with timestamp
date > "$LOG_FILE"
printf "\n" >> "$LOG_FILE"

for app_category_dir in $(find "$INSTALL_SCRIPTS_DIR" -mindepth 1 -maxdepth 1 -type d | sort); do
    IFS='/' read -ra path <<< "$app_category_dir"
    app_category_dir_name=${path[-1]}

    IFS='_' read -ra name_parts <<< "$app_category_dir_name"

    # install all apps inside current category
    printCategoryTitle "${name_parts[-1]}"

    # get install scripts by user decision for alternatives
    raw_install_script_paths=$(find "$app_category_dir" -mindepth 1 -maxdepth 1 -type f | sort)
    duplicates=()
    previousPrefix=""
    install_script_paths=()
    for file in $raw_install_script_paths; do
        filename=$(basename "${file}")
        prefix=${filename:0:3}
        if [[ "$previousPrefix" == "$prefix" ]]; then
            duplicates+=("$file")
        else
            if [[ ${#duplicates[@]} -gt 1 ]]; then
                selectedApp=$(select_app "${duplicates[@]}")
                install_script_paths+=("$selectedApp")
            else
                if [[ "$previousPrefix" != "" ]]; then
                    install_script_paths+=("${duplicates[0]}")
                fi
            fi
            duplicates=("$file")
        fi
        previousPrefix=$prefix
    done;
    if [[ ${#duplicates[@]} -eq 1 ]]; then
            install_script_paths+=("${duplicates[0]}")
    fi
    
    # run install scripts
    for install_script_path in "${install_script_paths[@]}"; do
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