#!/bin/bash
# .bash_aliases

echo "Aliases you can use:"
echo "    hm      --> go home
    rl      --> reload bash config
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
alias dnfi="dnf list installed"
alias dnfs="dnf search"
alias leaves="package-cleanup --leaves"
alias orphans="package-cleanup --orphans"
alias unused="rpmconf -a"
alias cleanconfig="rpmconf -c"
alias reaper="rpmreaper"

alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

alias home="/home/jasper"
alias hm="cd ~"
alias web="cd /home/jasper/_WEB"

alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit"

# programming

# alias startweb="cd /home/jasper/_WEB/react-styuled-gsap && npm storybook && sudo systemctl start docker && \
#   cd /home/jasper/_WEB/directus && \
#   sudo docker compose up -d"

# applications

# alias webstorm="exec '/home/jasper/.local/share/JetBrains/Toolbox/apps/WebStorm/ch-0/223.8214.51/bin/webstorm.sh'"
# SCRIPTZ
alias imgidx="/home/jasper/_WEB/my_bash/json_index.sh"
alias flatidx="/home/jasper/_WEB/my_bash/flat_index.sh"

# alias idxdir="find * -type d | sed -e 's/\.\/*//g' > index_folders.txt"