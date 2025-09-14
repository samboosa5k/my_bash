#!/bin/bash

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f $HOME/dev/my_bash/.bash_colors ]; then
    . $HOME/dev/my_bash/.bash_colors
fi

if [ -f $HOME/dev/my_bash/.bash_paths ]; then
    . $HOME/dev/my_bash/.bash_paths
fi

if [ -f /home/jasper/dev/my_bash/.bash_aliases ]; then
    . /home/jasper/dev/my_bash/.bash_aliases
fi

if [ -f /home/jasper/dev/my_bash/.bash_quick_aliases ]; then
    . /home/jasper/dev/my_bash/.bash_quick_aliases
fi

if [ -f /home/jasper/dev/my_bash/prompt/.bash_aliases ]; then
    . /home/jasper/dev/my_bash/prompt/.bash_aliases
fi
