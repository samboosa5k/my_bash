#!/bin/bash

echo "Aliases loaded"
echo "Yeah boooiiii!!!"

# Group - Basic
alias ss="sudo -s"
alias dnf="sudo dnf"
alias cc="clear"

# Group - config
alias cfg="vim ~/.bashrc"
alias editcfg="codium /home/jasper/_WEB/my_bash/"
alias helpme="/home/jasper/_WEB/my_bash/.bashrc_help"
alias rl="clear && source ~/.bashrc"

# Group - nav
alias hm="cd ~"
alias home="/home/jasper"
alias bkdir="/home/jasper/_WEB/my_bash/quick_alias.sh"
alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

# Group - Development
alias web="cd /home/jasper/_WEB"
alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit"

# Group - git (custom scripts)
alias bn="/home/jasper/_WEB/my_bash/git_branch_new.sh"
alias bb="/home/jasper/_WEB/my_bash/git_branch_find.sh"
alias bc="/home/jasper/_WEB/my_bash/git_change_utils.sh"
alias gbf="/home/jasper/_WEB/my_bash/git_branch_find.sh"
alias gbn="/home/jasper/_WEB/my_bash/git_branch_new.sh"
alias gg="/home/jasper/_WEB/my_bash/git_change_utils.sh"
alias co="/home/jasper/_WEB/my_bash/git_checkout_handler.sh"
alias gc="/home/jasper/_WEB/my_bash/git_commit_message.sh"

# Group - git
alias gb="git branch"
alias gd="git diff --name-only"
alias gbr="git branch -r"
alias gr="git reset --hard HEAD~1"
alias st="git status"
alias gpull="git pull"
alias gpush="git push"
alias gdiff="git diff --name-only"
alias gpulldev="git pull origin main --prune --autostash --recurse-submodules=true"
alias gaa="git add ."
alias gpforce="git push --force"
# alias gcurr="git branch --show-current"
#alias gpf="git add . && git commit -m -read"

# Group - network
alias lan="sudo arp-scan --interface=eno1 --localnet"
alias portscan="sudo nmap -sT -p- 192.168.1.126"

# Group - packages
alias dnfi="dnf list installed"
alias dnfs="dnf search"
alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

# Group - maintenance
alias leaves="package-cleanup --leaves"
alias orphans="package-cleanup --orphans"
alias unused="rpmconf -a"
alias cleanconfig="rpmconf -c"
alias reaper="rpmreaper"
alias clean_kernels="dnf repoquery --installonly --latest-limit=-2 -q | xargs sudo dnf remove"

# Group - updates
alias g_upgrade="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group upgrade "$grp" -y; done"
alias g_update="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group update "$grp" -y; done"
alias sys_update="dnf clean all -y && dnf autoremove && dnf upgrade --refresh -y && dnf distro-sync -y && dnf update"

# Group - Systemctl & Systemd
alias sysc="systemctl"
alias sysd="systemd"
alias sysblame="systemd blame"
alias syscrit="systemd-analyze critical-chain"
alias systime="systemd-analyze critical-chain"

# Group - experimental
alias imgidx="/home/jasper/_WEB/my_bash/json_index.sh"
alias flatidx="/home/jasper/_WEB/my_bash/flat_index.sh"
alias mkthumbs="/home/jasper/_WEB/my_bash/create_thumbnails.sh"
alias linenr="/home/jasper/_WEB/my_bash/prepend.sh"
alias capture="/home/jasper/_WEB/my_bash/util/capture.sh"

# Group - Other dependencies and cli packages
alias rip="/home/jasper/.local/bin/rip"
