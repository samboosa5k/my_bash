#!/bin/bash

# Configuration
alias cfg='cd $CFG_DIR && ls -A1'
alias rl="rm ~/.bashrc && cp $CFG_DIR/.bashrc $HOME && source ~/.bashrc"

# Basic
alias ss="sudo -s"
alias cc="clear"
alias ls="ls -A --color=auto"
alias home="/home/jasper"
alias xx="sudo systemctl poweroff -f"
alias off="sudo systemctl poweroff --now"

alias lsf="ls -p -A | grep -v /"
alias lsd="ls -d */"
alias lst="ls -lAt --time=mtime"

# Applications
alias webstorm="$HOME/.local/share/JetBrains/Toolbox/apps/webstorm/bin/webstorm.sh --new-window"
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

# Dependencies
if [ -f $CFG_DIR/development/.bash_aliases ]; then
    . $CFG_DIR/development/.bash_aliases
fi

# Experimental
# if [ -f $CFG_DIR/experimental/.bash_aliases ]; then
#     . $CFG_DIR/experimental/.bash_aliases
# fi
