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

export PATH=$PATH:/home/jasper/_WEB/roc_nightly-linux_x86_64-2024-11-29-d72da8e
export PATH=$PATH:/home/jasper/_WEB/roc_nightly-linux_x86_64-2024-11-29-d72da8e
export PATH=$PATH:/home/jasper/_WEB/roc_nightly-linux_x86_64-2024-11-29-d72da8e
export PATH=$PATH:/home/jasper/_WEB/roc_nightly-linux_x86_64-2024-11-29-d72da8e
export PATH=$PATH:/home/jasper/_WEB/roc_nightly-linux_x86_64-2024-11-29-d72da8e
