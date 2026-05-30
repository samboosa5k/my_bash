#!/bin/bash

#  set a fancy prompt for hostname and folder details
# Prompt hostname, @ sign, current folder, time, and $ sign
ps1_username_styled="\[\033[38;5;15m\]\u"
ps1_cat_emoji="\[\033[38;5;15m\]$kitty"
ps1_hostname="\[\033[38;5;214m\]\h"
ps1_at="\[\033[38;5;15m\]@"
ps1_folder="\[\033[38;5;39m\]\w"
# # Ps1 time aligned right
ps1_time="\[\033[38;5;15m\]\t"
# # Prompt new line > on new line
ps1_newline_symbol="\n\[\033[38;5;15m\]>"
# # ps1 git if in git repo
ps1_git_branch="\[\033[38;5;15m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"

# prompt string concatenated
PS1="$chicken\n$ps1_username_styled $ps1_at $ps1_hostname ($ps1_cat_emoji) $ps1_folder$ps1_git_branch$ps1_newline_symbol ($ps1_time) \n"

eval "$(dircolors -b)"

# Success message
log_success "Bash prompt loaded $happy"
