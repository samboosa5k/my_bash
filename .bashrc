#!/bin/bash

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f $HOME/_WEB/my_bash/.bash_colors ]; then
    . $HOME/_WEB/my_bash/.bash_colors
fi

if [ -f $HOME/_WEB/my_bash/.bash_paths ]; then
    . $HOME/_WEB/my_bash/.bash_paths
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

