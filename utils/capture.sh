#!/usr/bin/bash

function capture() {
    local cmd
    local cmd_location # which folder was the command run from
    local output_location
    local output_captured_count
    local output_file
    local cmd_header
    local cmd_subheader
    local cmd_wrapper
    local cmd_result
    local output_content

    # Prompt the user for a command
    printf "Enter a command to run:\n>"
    read -r cmd

    while [ -z "$cmd" ]; do
        printf "Enter a command to run:\n>"
        read -r cmd
    done

    initial_cmd="$(echo "$cmd" | awk '{print $1}')"
    cmd_location="$(pwd)"

    output_location="$HOME/Logs"
    mkdir -p "$output_location"

    output_captured_count="$(find "$output_location" -maxdepth 1 -iname "*$initial_cmd*" | wc -l)"
    # increment the count
    output_captured_count=$((output_captured_count + 1))
    output_file="${initial_cmd}_output_$output_captured_count.md"

    # Markdown formatting
    cmd_header="# Command log and output:"
    cmd_subheader="## Called from: $cmd_location"
    
    cmd_result=$(eval "$cmd" 2>&1)

    # Save output using printf to handle multi-line strings correctly
    {
        echo "$cmd_header"
        echo ""
        echo "$cmd_subheader"
        echo ""
        echo "### Command"
        echo '```bash'
        echo "$cmd"
        echo '```'
        echo ""
        echo "### Output"
        echo '```text'
        echo "$cmd_result"
        echo '```'
    } > "$output_location/$output_file"

    echo "Output saved to $output_location/$output_file"
    log_success "file://$output_location/$output_file"

    return 0
}

alias capture=capture
capture "$1"
