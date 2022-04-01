#!/bin/bash
export app_name="nvm"

function is_app_already_installed() {
    if [ -d "$USER_HOME/.nvm" ]; then
        return 1
    else
        return 0
    fi
}

function install_app() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$USER_HOME/.zshrc"
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> "$USER_HOME/.zshrc"
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> "$USER_HOME/.zshrc"

    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}
