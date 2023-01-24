#!/bin/bash
# ~/.bashrc
# clear

# if [ -f ~/.bash_functions ]; then
#   . ~/.bash_functions
# fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_quick_aliases ]; then
  . ~/.bash_quick_aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

######################################################################################
##		CUSTOM FUNCTIONS		    ##
######################################################################################

echo 'book function...'

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

# Foreach

echo "loop function..."

function foreach() {
  for n in $1; do
    "$2" $n
  done
}


# THEME

function theme_random() {
  echo "export mytheme='$(ls /home/jasper/.poshthemes/ | shuf -n 1)'" >~/.bash_theme
}

alias theme=$theme_random && $rl

echo $mytheme
eval "$(oh-my-posh init bash --config ~/.poshthemes/$mytheme)"
