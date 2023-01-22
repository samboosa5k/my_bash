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
# alias nr="count_files"
alias xb="exec bash"
alias ss="sudo -s"
alias dnfi="dnf list installed"
alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

alias hm="cd $home/"
alias web="cd $home/WEB"
alias dls="cd $home/Downloads"
alias music="cd $home/Music"
