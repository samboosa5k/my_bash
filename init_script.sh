#!/bin/bash

# Check if a parameter was passed else exit
function check_if_param_passed() {
    if [ -z "$1" ]; then
        echo 0
    else
        echo 1
    fi
}

alias check_if_param_passed=check_if_param_passed

function check_if_exists() {
    find . -maxdepth 1 -iname "$1" | wc -l
}

alias check_if_exists=check_if_exists

# Create new script
function init_script() {
    local script_name
    local bash_aliases_file

    script_name="$1"
    bash_aliases_file="$HOME/bash.conf.d/.bash_aliases"

    if check_if_exists "$script_name" -eq 0 && check_if_param_passed "$script_name" -eq 1; then
        # Create a new script
        touch "$(pwd)/$script_name.sh" &&
            cat "!/bin/bash \n $script_name \nfunction $script_name() { echo "Hello world" } \n\n
        alias $script_name=$script_name" >"$script_name.sh"
        # chmod the script
        chmod +x "$script_name.sh"
        echo "$script_name.sh created"
        # Add the script to the bash_aliases file
        echo "alias $script_name=$script_name" >>"$bash_aliases_file"
        echo "alias $script_name=$script_name added to $bash_aliases_file"
    else
        echo "Error: Not validated - script exists or no script name passed"
    fi

    return 0
}

init_script "$1"
