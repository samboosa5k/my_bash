#!/bin/bash

echo "Aliases loaded"
echo "Yeah boooiiii!!!"

# Group - Basic
alias ss="sudo -s"
alias dnf="sudo dnf"
alias cc="clear"

# Group - config
alias cfg='cd $HOME/bash.conf.d/ & ls -la $HOME/bash.conf.d/ && vim "./.bash_aliases"'
alias editcfg='codium $HOME/bash.conf.d/'
alias helpme='$HOME/bash.conf.d/.bashrc_help'
alias rl="clear && source ~/.bashrc"

# Group - nav
alias hm="cd ~"
alias home="/home/jasper"
alias bkdir='$HOME/bash.conf.d/quick_alias.sh'
alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

# Group - Development
alias web="cd /home/jasper/_WEB"
alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit"

# Group - git (custom scripts)
alias bn='$HOME/bash.conf.d/git_branch_new.sh'
alias bb='$HOME/bash.conf.d/git_branch_find.sh'
alias bc='$HOME/bash.conf.d/git_change_utils.sh'
alias gbf='$HOME/bash.conf.d/git_branch_find.sh'
alias gbn='$HOME/bash.conf.d/git_branch_new.sh'
alias gg='$HOME/bash.conf.d/git_change_utils.sh'
alias co='$HOME/bash.conf.d/git_checkout_handler.sh'
alias gc='$HOME/bash.conf.d/git_commit_message.sh'

# Group - git
alias gb="git branch"
alias gd="git diff --name-only"
alias gbr="git branch -r"
alias gr="git reset --hard HEAD~1"
alias st="git status"
# alias gpull="git pull"
# alias gpush="git push"
# alias gdiff="git diff --name-only"
# alias gpulldev="git pull origin main --prune --autostash --recurse-submodules=true"
# alias gaa="git add ."
# alias gpforce="git push --force"
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
# alias g_upgrade="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group upgrade "$grp" -y; done"
# alias g_update="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group update "$grp" -y; done"
# alias sys_update="dnf clean all -y && dnf autoremove && dnf upgrade --refresh -y && dnf distro-sync -y && dnf update"

# Group - Systemctl & Systemd
alias sysc="systemctl"
alias sysd="systemd"
alias sysblame="systemd blame"
alias syscrit="systemd-analyze critical-chain"
alias systime="systemd-analyze critical-chain"

# Group - experimental
alias imgidx='$HOME/bash.conf.d/json_index.sh'
alias flatidx='$HOME/bash.conf.d/flat_index.sh'
alias mkthumbs='$HOME/bash.conf.d/create_thumbnails.sh'
alias linenr='$HOME/bash.conf.d/prepend.sh'
alias capture='$HOME/bash.conf.d/capture.sh'
alias cap='$HOME/bash.conf.d/capture.sh'
alias fwrite='$HOME/bash.conf.d/fwrite.sh'
alias init_script='$HOME/bash.conf.d/init_script.sh'

# Group - Other dependencies and cli packages
alias rip='/home/jasper/.local/bin/rip'
alias hello=hello
