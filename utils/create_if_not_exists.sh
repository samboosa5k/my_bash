#!/bin/bash

if [-f "$CFG_DIR"/utils/get_type.sh ]; then
    . "$CFG_DIR"/utils/get_type.sh
fi

function create_if_not_exists() {
    local target
    local target_path
    local target_type

    if [ -z "$1" ] || [[ ${#} -gt 1 ]]; then
        colorize_stdout "$ERROR_RED" "Error: Invalid number of arguments"
        colorize_stdout "$INFO_BLUE" "Usage: create_if_not_exists <target>"
        exit 1
    fi

    target="$1"
    target_path=$(echo "$target" | sed 's/\/[^/]*$//')
    target_type=$(get_type "$target_path" "$target")

    if [ "$target_type" == "DOES_NOT_EXIST" ]; then
        mkdir -p "$target"
        colorize_stdout "$SUCCESS_GREEN" "Directory created: $target"
    else
        colorize_stdout "$INFO_BLUE" "Directory already exists: $target"
    fi

    return 0
}
