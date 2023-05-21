#!/bin/bash
# ~/.bashrc
# clear

# load /etc/bashrc
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_quick_aliases ]; then
 . ~/.bash_quick_aliases
fi

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

eval "$(dircolors -b)"
export alias ls="ls -a1 --color=auto"
export alias dnf="sudo dnf"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

######################################
##		CUSTOM FUNCTIONS		    ##
######################################

# echo 'book function...'

function book() {
  local existsAlias
  local currDir
  currDir="$(basename "$(pwd)")"

  if [ "$#" -eq 0 ]; then
    existsAlias="$(grep -c "alias $currDir" <  ~/.bash_quick_aliases)"

    if [ "$existsAlias" -eq 0 ]; then
      printf "%f" "\n No args passed, booking -> alias $currDir in .bash_aliases \n"
      echo "alias $currDir='cd $(pwd)'" >>~/.bash_quick_aliases
    else
      printf "\n else something \n"
    fi
  elif [ "$#" -eq 1 ]; then
    existsAlias="$(grep -c "alias $1" <  ~/.bash_quick_aliases)"

    if [ "$existsAlias" -eq 0 ]; then
      printf "%f" "\n Thank you for the arg, will book $1 in .bash_quick_aliases \n"
      echo "alias $1='cd $(pwd)'" >>~/.bash_quick_aliases
    else
      printf "\n else something \n"
    fi
  else
    printf "no action"
  fi
}

export alias book=book
