#!/bin/bash

# Configuration
alias cfg='cd $CFG_DIR && ls -A1'
alias rl="clear && source ~/.bashrc"

# Basic
alias ss="sudo -s"
alias cc="clear"
alias ls="ls -AG"
alias home="/Users/jasper"
alias xx="echo 'Poweroff disabled on macOS branch'"
alias off="echo 'Poweroff disabled on macOS branch'"

alias lsf="find . -maxdepth 1 -type f | grep -E '.*\w+'"
alias lsd="find . -maxdepth 1 -type d"
alias lst="ls -lAt --time=mtime"

# Applications
# (Disabled on macOS branch)

# CLI applications
# (Disabled on macOS branch)

# Git scripts
if [ -f $CFG_DIR/git_scripts/.bash_aliases ]; then
    . $CFG_DIR/git_scripts/.bash_aliases
fi

# Utils
if [ -f $CFG_DIR/utils/.bash_aliases ]; then
    . $CFG_DIR/utils/.bash_aliases
fi

# Success message
log_success "Main aliases loaded $happy"
