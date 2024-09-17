#!/bin/bash

# Basic
alias gb="git branch"
alias gd="git diff --name-only"
alias gbr="git branch -r"
alias gr="git reset --hard HEAD~1"
alias st="git status"

# Custom scripts
alias bn='$CFG_DIR/git_scripts/git_branch_new.sh'
alias bb='$CFG_DIR/git_scripts/git_branch_find.sh'
alias bc='$CFG_DIR/git_scripts/git_change_utils.sh'
alias gbf='$CFG_DIR/git_scripts/git_branch_find.sh'
alias gbn='$CFG_DIR/git_scripts/git_branch_new.sh'
alias gg='$CFG_DIR/git_scripts/git_change_utils.sh'
alias co='$CFG_DIR/git_scripts/git_checkout_handler.sh'
alias gc='$CFG_DIR/git_scripts/git_commit_message.sh'

# Success message
echo "Git aliases loaded $happy"
