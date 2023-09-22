#!/bin/bash
# quick_alias.sh
# quick alias for booking a directory
# usage: bkdir [alias]
# if no alias is passed, the current directory name will be used
# if an alias is passed, it will be used
# if the alias is already in use, it will not be overwritten

function bkdir() {
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
      printf "%f" "\n Thank you for the arg, will add alias $1 in .bash_quick_aliases \n"
      echo "alias $1='cd $(pwd)'" >>~/.bash_quick_aliases
    else
      printf "\n else something \n"
    fi
  else
    printf "no action"
  fi
}

alias bkdir=bkdir
bkdir "$1"
