#!/bin/bash
export app_name="git"

function is_app_already_installed() {
    if ! command -v git &> /dev/null ; then
        return 0
    else
        return 1
    fi
}

function install_app() {
    sudo apt install -y git

    # set default config
    git config --global push.default matching
    git config --global pull.rebase true
    git config --global branch.autosetuprebase always
    git config --global status.short true
    git config --global alias.last "log -1 --stat"
    git config --global alias.cp "cherry-pick"
    git config --global alias.co "checkout"
    git config --global alias.cl "clone"
    git config --global alias.ci "commit"
    git config --global alias.st "status -sb"
    git config --global alias.br "branch"
    git config --global alias.unstage "reset HEAD --"
    git config --global alias.dc "diff --cached"
    git config --global alias.lg1 "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
    git config --global alias.lg2 "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
    git config --global alias.lg "!(git lg2)"
}