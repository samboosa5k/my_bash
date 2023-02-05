#!/bin/bash
# .bash_aliases

if [ -f ~/.bash_theme ]; then
  . ~/.bash_theme
fi

# CONSTANTS
export home='/home/jasper'
export aliases="$home/.bash_aliases"

echo 'loading aliases...'

alias rl="source $home/.bashrc"
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
alias dls="cd $home/Downloads"
alias music="cd $home/Music"
