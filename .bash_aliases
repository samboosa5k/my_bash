# !/bin/bash
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

export home='/home/jasper'
export aliases="$home/.bash_aliases"

alias rl="clear && source $home/.bashrc"
alias cc="clear"
alias st="git status"
alias gd="git diff --name-only"

alias ss="sudo -s"
alias dnfi="dnf list installed"
alias dnfs="dnf search"
alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

# alias savebash="for n in $(lsf | grep 'bash'); do cp './$n' '/home/jaser/WEB/my_bash/$n';  done"

alias hm="cd $home"
alias web="cd $home/WEB"

# applications
alias webstorm="exec '/home/jasper/.local/share/JetBrains/Toolbox/apps/WebStorm/ch-0/223.8214.51/bin/webstorm.sh'"
