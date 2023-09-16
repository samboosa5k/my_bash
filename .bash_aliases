#!/bin/bash
# .bash_aliases

printf "Aliases loaded"
echo "Yeah boooiiii!!!"

alias ss="sudo -s"

# config and basic
alias cfg="vim ~/.bashrc"
alias rl="clear && source ~/.bashrc"
alias cc="clear"
alias hm="cd ~"
alias home="/home/jasper"

# nerdy stuff
alias web="cd /home/jasper/_WEB"
alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit"
alias st="git status"
alias gd="git diff --name-only"

# nav
alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

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

#
# firemon(1),  firecfg(1),  firejail-profile(5), firejail-login(5), fire‐
#       jail-users(5), jailcheck(1)

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

# firewall
# sudo systemctl unmask firewalld
# sudo systemctl enable firewalld
# sudo systemctl start firewalld

# SCRIPTZ
alias imgidx="/home/jasper/_WEB/my_bash/json_index.sh"
alias flatidx="/home/jasper/_WEB/my_bash/flat_index.sh"
alias mkthumbs="/home/jasper/_WEB/my_bash/create_thumbnails.sh"
alias linenr="/home/jasper/_WEB/my_bash/prepend.sh"

# GIT
alias noob="/home/jasper/_WEB/my_bash/git_branch_helpers.sh"
alias bb="/home/jasper/_WEB/my_bash/git_branch_utils.sh"
alias gcb="git checkout -b"
alias gco="/home/jasper/_WEB/my_bash/git_branch_utils.sh"
alias gb="git branch"
alias gbr="git branch -r"
alias st="git status"

alias lan="sudo arp-scan --interface=eno1 --localnet"
alias portscan="sudo nmap -sT -p- 192.168.1.126"

# podman
# alias docker="podman"
# alias docker-compose="podman-compose"
# alias vol="podman volume ls"
# alias cnt="podman container ls"
# alias image="podman image ls"
# alias rs="podman-compose restart"
# alias duck="podman-compose"
