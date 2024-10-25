#!/bin/bash

# Prompt style and colors

# Colors
PINK="\e[45m"
BLUE="\e[44m"
YELLOW="\e[1;33m"
WHITE="\e[1;37m"
RED="\e[41m"
GREEN="\e[42m"
RESET_COLOR="\e[0m"

function prompt() {
    local bg_color
    local fg_color
    local text
    local type
    local fullwidth

    if [ -z "$1" ]; then
        echo "Usage: prompt <text> <type> <fullwidth>"
        return 1
    else
        text="$1"
    fi

    # set colors based on type
    if [ -z "$2" ]; then
        type="default"
    else
        type="$2"
    fi

    echo "Type: $type"

    case $type in
    "info")
        bg_color=$BLUE
        fg_color=$WHITE
        ;;
    "error")
        bg_color=$RED # Red background
        fg_color=$WHITE
        ;;
    "success")
        bg_color=$GREEN # Green background
        fg_color=$WHITE
        ;;
    "warning")
        bg_color=$YELLOW
        fg_color=$WHITE
        ;;
    "default")
        bg_color=$BLUE  # Red background
        fg_color=$WHITE
        ;;
    *)
        bg_color=$BLUE  # Blue background
        fg_color=$WHITE
        ;;
    esac

    # set fullwidth
    if [ -z "$3" ]; then
        fullwidth="false"
    else
        fullwidth="$3"
    fi

    local prompt_columns
    local prompt_length
    local prompt_spaces
    local left
    local right

    if [ "$fullwidth" = "true" ]; then
        prompt_columns=$(tput cols)
        prompt_length=${#text}
        prompt_spaces=$((($prompt_columns - $prompt_length) / 2))
        left="${bg_color}${fg_color}$(printf '%*s' $prompt_spaces)"
        right=$(printf '%*s' $prompt_spaces)${RESET_COLOR}

        echo -e "${left}${text}${right}"
    else
        echo -e "${bg_color}${fg_color}${text}${RESET_COLOR}"
    fi

    return 0
}

alias prompt=prompt

# Script to create rescue folders and files for chroot

MOUNT_DIR="/rescue"
CHROOT_DIRS="dev proc sys"

function create_rescue_folders() {
    if [ -d $MOUNT_DIR ]; then
        echo "Rescue folder already exists"
    else
        echo
        mkdir -p $MOUNT_DIR

        for dir in $CHROOT_DIRS; do
            if [ -d $MOUNT_DIR/$dir ]; then
                echo "Rescue folder $dir already exists"
            else
                mkdir -p $MOUNT_DIR/$dir
            fi
        done
    fi

    mkdir -p $MOUNT_DIR
    mkdir -p $MOUNT_DIR/{dev,proc,sys}
}

alias create_rescue_folders=create_rescue_folders

AVAILABLE_SCRIPTS="prompt create_rescue_folders"

function run_script() {
    local script_to_run
    local args

    if [ -z "$1" ]; then
        prompt "Usage: run_script <script_to_run>" "info"

        echo "Available scripts:"

        for script in $AVAILABLE_SCRIPTS; do
            echo "  $script"
        done

        return 1
    else
        script_to_run=$1
    fi

    if [[ ! " $AVAILABLE_SCRIPTS " =~ " $script_to_run " ]]; then
        echo "Script $script_to_run not found"
        return 1
    fi

    # set args
    if [ -z "$2" ]; then
        args=""
    else
        args="${@:2}"
    fi
    # run script and pass all arguments
    $script_to_run $args

    return 0
}

alias run_script=run_script

# pass all arguments to run_script
run_script "${@:1}"
