#!/bin/bash

# Load Environment and Constants
if [ -f $HOME/dev/my_bash/.bash_env ]; then
    . $HOME/dev/my_bash/.bash_env
fi

# System-wide bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Load Colors
if [ -f $CFG_DIR/.bash_colors ]; then
    . $CFG_DIR/.bash_colors
fi

# Load Colorization Functions
if [ -f $CFG_DIR/prompt/colorize_stdout.sh ]; then
    . $CFG_DIR/prompt/colorize_stdout.sh
fi

# Load Paths
if [ -f $CFG_DIR/.bash_paths ]; then
    . $CFG_DIR/.bash_paths
fi

# Load Aliases
if [ -f $CFG_DIR/.bash_aliases ]; then
    . $CFG_DIR/.bash_aliases
fi

if [ -f $CFG_DIR/.bash_quick_aliases ]; then
    . $CFG_DIR/.bash_quick_aliases
fi

# Load Prompt
if [ -f $CFG_DIR/prompt/.bash_aliases ]; then
    . $CFG_DIR/prompt/.bash_aliases
fi
