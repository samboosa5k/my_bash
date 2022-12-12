#!/bin/bash
# ~/.bashrc

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_quick_aliases ]; then
  . ~/.bash_quick_aliases
fi

######################################################################################
##		CUSTOM FUNCTIONS		    ##
######################################################################################

echo 'loading custom functions...'

function book() {
  local fullPath="$PWD"
  local dirName="${fullPath##*/}"
  local existsAlias="$(grep -w "alias $dirName" /home/jasper/.bash_aliases)"
  local existsAlias2="$(grep -w "alias $dirName" /home/jasper/.bash_quick_aliases)"

  local len1=${#existsAlias}
  local len2=${#existsAlias2}

  if [ $len2 -gt 0 ] || [ $len1 -gt 0 ]; 
  then
      echo "Alias for $dirName already exists"
  else
    echo "No alias here..."
    echo "alias $dirName='cd $PWD'" >> '/home/jasper/.bash_quick_aliases'
    echo "Created alias for $dirName in ~/.bash_quick_aliases"
    $rl
  fi
}

function theme() {
  echo "$(ls /home/jasper/.poshthemes/ | shuf -n 1)"
}

randTheme=$(theme)
eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/$randTheme)"

#### For Loop over filesz

function loop() {
  for n in $@; do
    item="$n"
    echo $item
    cat $item
  done
}

######################################################################################
##		OTHER SETTINGS		    ##
######################################################################################


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

######################################################################################
##		FROM POP_OS UBUNTU DEFAULT CONFIG			    ##
######################################################################################



[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
