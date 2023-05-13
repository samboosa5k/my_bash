#!/bin/bash
# ~/.bashrc
# clear

# load /etc/bashrc
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

#if [ -f ~/.bash_functions ]; then
#  . ~/.bash_functions
#fi
#
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
#
#if [ -f ~/.bash_quick_aliases ]; then
#  . ~/.bash_quick_aliases
#fi

#  set a fancy prompt for hostname and folder details
# Prompt hostname, @ sign, current folder, time, and $ sign
ps1_username_styled="\[\033[38;5;15m\]\u"
ps1_cat_emoji="\[\033[38;5;15m\]🐱"
ps1_hostname="\[\033[38;5;214m\]\h"
ps1_at="\[\033[38;5;15m\]@"
ps1_folder="\[\033[38;5;39m\]\w"
# Ps1 time aligned right
ps1_time="\[\033[38;5;15m\]\t"
# Prompt new line > on new line
ps1_newline_symbol="\n\[\033[38;5;15m\]>"
# ps1 git if in git repo
ps1_git_branch="\[\033[38;5;15m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"

# prompt string concatenated
PS1="$ps1_username_styled $ps1_at $ps1_hostname ($ps1_cat_emoji) $ps1_folder$ps1_git_branch$ps1_newline_symbol ($ps1_time) "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

######################################
##		CUSTOM FUNCTIONS		    ##
######################################

# echo 'book function...'

function book() {
  local fullPath="$PWD"
  local dirName="${fullPath##*/}"
  local existsAlias="$(grep -w "alias $dirName" /home/jasper/.bash_aliases)"
  local existsAlias2="$(grep -w "alias $dirName" /home/jasper/.bash_quick_aliases)"

  local len1=${#existsAlias}
  local len2=${#existsAlias2}

  if [ $len2 -gt 0 ] || [ $len1 -gt 0 ]; then
    echo "Alias for $dirName already exists"
  else
    echo "No alias here..."
    echo "alias $dirName='cd $PWD'" >>'/home/jasper/.bash_quick_aliases'
    echo "Created alias for $dirName in ~/.bash_quick_aliases"
    $rl
  fi
}

export ls_options='--color=auto'
eval "$(dircolors -b)"
alias ls='ls -a1 $ls_options'
