#!/bin/bash
export app_name="zsh + oh-my-zsh"

function is_app_already_installed() {
    if [ -d "$USER_HOME/.oh-my-zsh" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    cd "$TMP_DIR" || exit
    
    # install zsh
    sudo apt -y install zsh

    # install oh-my-zsh
    curl -Lo install-zsh.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh &> /dev/null
    sh install-zsh.sh --unattended &> /dev/null
    rm -f install-zsh.sh

    # add plugin: syntax highlighting
    [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &> /dev/null
    chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    enablePlugin "zsh-syntax-highlighting"

    # add plugin: suggestions
    [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &> /dev/null
    chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    enablePlugin "zsh-autosuggestions"
    
    enablePlugin "extract"
}

function enablePlugin() {
    pluginName=$1
    sed -i "s/^plugins=(\(.*\))/plugins=(\1 $pluginName)/g" ~/.zshrc
}
