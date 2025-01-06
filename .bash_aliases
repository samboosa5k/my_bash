#!/bin/bash

export alias CFG_DIR="/home/jasper/_WEB/my_bash"

# Configuration
alias cfg='cd $CFG_DIR && ls -a1'
alias rl="clear && source ~/.bashrc"

# Basic
alias ss="sudo -s"
alias cc="clear"
alias ls="ls -a1 --color=auto"
alias hm="cd ~"
alias home="/home/jasper"
alias xx="sudo systemctl poweroff -f"
alias off="sudo systemctl poweroff --now"

alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

# Applications
alias web="cd /home/jasper/_WEB"
# alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit" # this IDE is no longer in use
alias zed="~/.local/bin/zed"

# CLI applications
alias rip='/home/jasper/.local/bin/rip'

# Git scripts
if [ -f $CFG_DIR/git_scripts/.bash_aliases ]; then
    . $CFG_DIR/git_scripts/.bash_aliases
fi

# System
if [ -f $CFG_DIR/system/.bash_aliases ]; then
    . $CFG_DIR/system/.bash_aliases
fi

# Utils
if [ -f $CFG_DIR/utils/.bash_aliases ]; then
    . $CFG_DIR/utils/.bash_aliases
fi

# Paths
if [ -f $CFG_DIR/paths/.bash_aliases ]; then
    . $CFG_DIR/paths/.bash_aliases
fi

# Dependencies
if [ -f $CFG_DIR/dependencies/.bash_aliases ]; then
    . $CFG_DIR/dependencies/.bash_aliases
fi

# Experimental
# if [ -f $CFG_DIR/experimental/.bash_aliases ]; then
#     . $CFG_DIR/experimental/.bash_aliases
# fi

echo "Aliases loaded"
echo "Yeah boooiiii!!!"
