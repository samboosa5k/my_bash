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

alias cfg="vim ~/.bashrc"
alias rl="clear && source ~/.bashrc"
alias cc="clear"
alias st="git status"
alias gd="git diff --name-only"

alias ss="sudo -s"

# FIERWAL
# sudo systemctl unmask firewalld
# sudo systemctl enable firewalld
# sudo systemctl start firewalld

alias home="/home/jasper"
alias hm="cd ~"
alias web="cd /home/jasper/_WEB"

alias dnfi="dnf list installed"
alias dnfs="dnf search"
alias leaves="package-cleanup --leaves"
alias orphans="package-cleanup --orphans"
alias unused="rpmconf -a"
alias cleanconfig="rpmconf -c"
alias reaper="rpmreaper"

alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

# updates etc
#

alias g_upgrade="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group upgrade "$grp" -y; done"
alias g_update="for grp in "cinnamon-desktop" "admin-tools" "container-management" "development-tools" "editors" "hardware-support" "system-tools"; do dnf group update "$grp" -y; done"
alias sys_update="dnf clean all -y & dnf autoremove & dnf upgrade --refresh -y & dnf distro-sync -y & dnf update"

alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit"

# SCRIPTZ
alias imgidx="/home/jasper/_WEB/my_bash/json_index.sh"

alias flatidx="/home/jasper/_WEB/my_bash/flat_index.sh"
alias mkthumbs="/home/jasper/_WEB/my_bash/create_thumbnails.sh"

# alias idxdir="find * -type d | sed -e 's/\.\/*//g' > index_folders.txt"
