#!/bin/bash

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f /home/jasper/_WEB/my_bash/.bash_aliases ]; then
    . /home/jasper/_WEB/my_bash/.bash_aliases
fi

if [ -f /home/jasper/_WEB/my_bash/.bash_quick_aliases ]; then
    . /home/jasper/_WEB/my_bash/.bash_quick_aliases
fi

if [ -f /home/jasper/_WEB/my_bash/prompt/.bash_aliases ]; then
    . /home/jasper/_WEB/my_bash/prompt/.bash_aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
