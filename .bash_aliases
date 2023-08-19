#!/bin/bash
# .bash_aliases

echo "Aliases you can use:"
printf "
\thm      --> go home
  \n\t  rl      --> reload bash config
  \t  cfg --> edit bashrc
  \t cfg_src --> _WEB/my_bash
    cc      --> clear terminal
    lsf     --> list files only
    lsd     --> list directories only
    dnfi    --> list installed
    dnfs    --> search
    gli     --> list group installed
    gl      --> grouplist
    st      --> git status
    gd      --> git diff names only
    "
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

# updates
alias g_upgrade="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group upgrade "$grp" -y; done"
alias g_update="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group update "$grp" -y; done"
alias sys_update="dnf clean all -y & dnf autoremove & dnf upgrade --refresh -y & dnf distro-sync -y & dnf update"

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

alias lan="arp-scan --interface=eno1 --localnet"
alias portscan="sudo nmap -sT -p- 192.168.1.126"

# podman
alias docker="podman"
alias docker-compose="podman-compose"
alias vol="podman volume ls"
alias cnt="podman container ls"
alias image="podman image ls"
alias rs="podman-compose restart"
alias duck="podman-compose"
