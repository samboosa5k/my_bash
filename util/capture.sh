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

    initial_cmd=$(echo "$cmd" | cut -d' ' -f1)
    cmd_location="$(pwd)"
    if [ -z "$cmd" ]; then
        echo "Usage: capture 'command'"
        return 1
    fi

    output_location="$HOME/Logs"
    output_captured_count="$(find "$output_location" -maxdepth 1 -iname "*$initial_cmd*" | wc -l)"
    # increment the count
    output_captured_count=$((output_captured_count + 1))
    output_file="$(basename "$0" .sh)_output_$output_captured_count.md"

    # Markdown formatting
    cmd_header="# Command log and output:"
    cmd_subheader="# Called from: $cmd_location"
    cmd_wrapper="\`\`\`bash"
    cmd_wrapper="$cmd_wrapper\n$cmd\n\`\`\`"

    cmd_result=$(eval "$cmd" 2>&1)
    cmd_result="\`\`\`bash\n$cmd_result\n\`\`\`"

    output_content="$cmd_header\n\n$cmd_subheader\n\n$cmd_wrapper\n\n$cmd_result"

    # save the output to a file
    echo -e "$output_content" >"$output_location/$output_file"
    echo "Output saved to $output_location/$output_file"
    echo "file://$output_location/$output_file"

    return 0
}

alias capture=capture
capture "$1"
