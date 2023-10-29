#!/bin/bash

echo "Aliases loaded"
echo "Yeah boooiiii!!!"

alias ss="sudo -s"

# config and basic
alias cfg="vim ~/.bashrc"
alias rl="clear && source ~/.bashrc"
alias cc="clear"
alias hm="cd ~"
alias home="/home/jasper"

# nav
alias bkdir="/home/jasper/_WEB/my_bash/quick_alias.sh"
alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

# development
alias web="cd /home/jasper/_WEB"
alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit"

# git
alias bn="/home/jasper/_WEB/my_bash/git_branch_new.sh"
alias bb="/home/jasper/_WEB/my_bash/git_branch_find.sh"
alias bc="/home/jasper/_WEB/my_bash/git_change_utils.sh"
alias gbf="/home/jasper/_WEB/my_bash/git_branch_find.sh"
alias gbn="/home/jasper/_WEB/my_bash/git_branch_new.sh"
alias gg="/home/jasper/_WEB/my_bash/git_change_utils.sh"
alias co="/home/jasper/_WEB/my_bash/git_checkout_handler.sh"
alias gc="/home/jasper/_WEB/my_bash/git_commit_message.sh"
alias gb="git branch"
alias gd="git diff --name-only"
alias gbr="git branch -r"
alias st="git status"
alias gpull="git pull"
alias gpush="git push"
alias gdiff="git diff --name-only"
alias gpulldev="git pull origin main --prune --autostash --recurse-submodules=true"
# alias gcurr="git branch --show-current"

alias gaa="git add ."
alias gpforce="git push --force"
#alias gpf="git add . && git commit -m -read"

# network
alias lan="sudo arp-scan --interface=eno1 --localnet"
alias portscan="sudo nmap -sT -p- 192.168.1.126"

# packages
alias dnfi="dnf list installed"
alias dnfs="dnf search"
alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

# maintenance
alias leaves="package-cleanup --leaves"
alias orphans="package-cleanup --orphans"
alias unused="rpmconf -a"
alias cleanconfig="rpmconf -c"
alias reaper="rpmreaper"
alias clean_kernels="dnf repoquery --installonly --latest-limit=-2 -q | xargs sudo dnf remove"

# updates
alias g_upgrade="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group upgrade "$grp" -y; done"
alias g_update="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group update "$grp" -y; done"
alias sys_update="dnf clean all -y && dnf autoremove && dnf upgrade --refresh -y && dnf distro-sync -y && dnf update"

# Systemctl & Systemd
alias sysc="systemctl"
alias sysd="systemd"
alias sysblame="systemd blame"
alias syscrit="systemd-analyze critical-chain"
alias systime="systemd-analyze critical-chain"

# experimental
alias imgidx="/home/jasper/_WEB/my_bash/json_index.sh"
alias flatidx="/home/jasper/_WEB/my_bash/flat_index.sh"
alias mkthumbs="/home/jasper/_WEB/my_bash/create_thumbnails.sh"
alias linenr="/home/jasper/_WEB/my_bash/prepend.sh"
