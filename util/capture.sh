#!/usr/bin/bash

# eval the argument to store the command as a string and store the output in log file in this scripts directory

function capture() {
    local cmd
    local output_location
    local output_captured_count
    local output_file
    local cmd_location # which folder was the command run from
    local cmd_output_header
    local cmd_result

    cmd=$1
    if [ -z "$cmd" ]; then
        echo "Usage: capture 'command'"
        return 1
    fi

    output_location=$(dirname "$0")
    output_captured_count=$(find "$output_location" -maxdepth 1 -iname "*_output.txt" | wc -l)
    output_file="$(basename "$0" .sh)_output_$output_captured_count.txt"

    cmd_location="$(pwd)"
    cmd_output_header="# Command: $cmd\n
    # Called from: $cmd_location"

    # cmd_result=$(eval "$cmd")
    # eval the command, but echo it to the terminal and store the output in a variable
    cmd_result=$(eval "$cmd" 2>&1)

    echo -e "$cmd_output_header\n\n$cmd_result" >"$output_location/$output_file"
    echo "Output saved to $output_location/$output_file"
    # link to the output file - clickable in terminal
    echo "file://$output_location/$output_file"

    return 0
}

alias capture=capture
capture "$1"
