#!/usr/bin/bash

# eval the argument to store the command as a string and store the output in log file in this scripts directory

function capture() {
    local cmd
    local cmd_result
    local cmd_location # which folder was the command run from
    local cmd_output_header
    local output_location
    local output_file

    cmd=$1
    cmd_result=$(eval "$cmd")

    output_location=$(dirname "$0")

    cmd_output_header="Command: $cmd\n
    Called from: $cmd_location"

    cmd_location="$(pwd)"
    output_file="$(basename "$0")_output.txt"

    echo -e "$cmd_output_header\n\n$cmd_result" >"$output_location/$output_file"
    echo "Output saved to $output_location/$output_file"
    # link to the output file - clickable in terminal
    echo "file://$output_location/$output_file"

    return 0
}

alias capture=capture
capture "$1"

The script is called with the command to be run as an argument.
$ ./capture.sh "ls -l"

The output is saved in a file in the same directory as the script.
Command: ls -l
