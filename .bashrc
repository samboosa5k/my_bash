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

export PATH=$PATH:/home/jasper/_WEB/ROC_CLI_DEV/roc_nightly-linux_x86_64-2025-03-04-3da0934
export PATH=$PATH:/home/jasper/_WEB/ROC_CLI_DEV/elm_0.19.1_linux-64-bit_binary
export alias elm=/home/jasper/_WEB/ROC_CLI_DEV/elm_0.19.1_linux-64-bit_binary/elm
export PATH=$PATH:/home/jasper/_WEB/roc_elm_setup_script/elm_0.19.1_linux-64-bit_binary
export alias elm=/home/jasper/_WEB/roc_elm_setup_script/elm_0.19.1_linux-64-bit_binary/elm
export PATH=$PATH:/home/jasper/_WEB/roc_elm_setup_script/roc_nightly-linux_x86_64-2025-03-04-3da0934
