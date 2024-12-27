#!/bin/bash

export alias CFG_DIR="/home/jasper/_WEB/my_bash"

# Configuration
alias cfg='cd $CFG_DIR && ls -a1'
alias rl="clear && source ~/.bashrc"

# Basic
alias ss="sudo -s"
alias cc="clear"
alias ls="ls -a1 --color=auto"
alias hm="cd ~"
alias home="/home/jasper"
alias xx="sudo systemctl poweroff -f"

alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

# Navigation special
function log_navigation() {
    local destination
    local current_location="$PWD"

    # update the location log with the current location, destination, and the current date
    if [ -z "$1" ]; then
        destination="$1"
    else
        destination="$PWD"
    fi

    local location_log_file="$HOME/Logs/location_log.csv"
    if [ -f "$location_log_file" ]; then
        # display the last 3 recorded locations
        tail -n 3 "$location_log_file"
        # add the current, destination, and date to the location log
        echo "$current_location,$destination,$(date)" >>"$location_log_file"
    else
        # create the file and add the current location to it
        echo "Location,Destination,Date" >"$location_log_file"
        echo "$current_location,$destination,$(date)" >>"$location_log_file"
    fi
    return 0
}

function list_contents_table() {
    # table should display folders in the first column, and files in the second column
    # max width of the first column is 50% of the terminal width
    # max width of the second column is 50% of the terminal width
    # each other row should have a pastel purple background with 50% opacity
    # max nr of rows is 10
    local total_terminal_columns=$(tput cols)
    local table

    # format the initial table row
    table="| $(printf "%-50s" "Folder") | $(printf "%-50s" "File") |"
    local destination_dirs_10=$(ls -d */ | head -n 10)
    local destination_files_10=$(ls -p | grep -v / | head -n 10)

    # add the destination directories and files to the table
    for i in {1..10}; do
        table="$table\n| $(printf "%-50s" "${destination_dirs_10[$i]}") | $(printf "%-50s" "${destination_files_10[$i]}") |"
    done
    echo -e "$table"Date

    return 0
}

function to() {
    local destination
    local destination_contents

    # if a destination is provided:
    #  - if the directory exists, navigate to it
    #  - if the directory doesn't exist, list the directories one level up from the destination
    # if the destinaton is a file, navigate to its parent directory
    if [ -n "$1" ]; then
        destination="$1"
        if [ -d "$destination" ]; then
            # update the location log with the current location, destination, and the current date
            log_navigation $destination
            cd "$destination"
            # list_contents_table

        elif
            [ -f "$destination" ]
        then
            cd "$(dirname "$destination")"
        else
            destination_contents=$(ls -d "$destination"*/)
            if [ -n "$destination_contents" ]; then
                echo "$destination_contents"
            else
                echo "No such directory: $destination"
            fi
        fi
    fi

    return 0
}

alias to=to

# Applications
alias web="cd /home/jasper/_WEB"
# alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit" # this IDE is no longer in use
alias zed="~/.local/bin/zed"

# CLI applications
alias rip='/home/jasper/.local/bin/rip'

# Git scripts
if [ -f $CFG_DIR/git_scripts/.bash_aliases ]; then
    . $CFG_DIR/git_scripts/.bash_aliases
fi

# System
if [ -f $CFG_DIR/system/.bash_aliases ]; then
    . $CFG_DIR/system/.bash_aliases
fi

# Utils
if [ -f $CFG_DIR/utils/.bash_aliases ]; then
    . $CFG_DIR/utils/.bash_aliases
fi

# Paths
if [ -f $CFG_DIR/paths/.bash_aliases ]; then
    . $CFG_DIR/paths/.bash_aliases
fi

# Dependencies
if [ -f $CFG_DIR/dependencies/.bash_aliases ]; then
    . $CFG_DIR/dependencies/.bash_aliases
fi

# Experimental
# if [ -f $CFG_DIR/experimental/.bash_aliases ]; then
#     . $CFG_DIR/experimental/.bash_aliases
# fi

echo "Aliases loaded"
echo "Yeah boooiiii!!!"
