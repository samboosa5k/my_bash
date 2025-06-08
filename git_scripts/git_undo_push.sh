#!/bin/bash

# Load colorized prompt shell functions

if [ -f "$CFG_DIR"/prompt/colorize_stdout.sh ]; then
    . "$CFG_DIR"/prompt/colorize_stdout.sh
fi

if [ -f "$CFG_DIR"/prompt/decorate_stdout.sh ]; then
    . "$CFG_DIR"/prompt/decorate_stdout.sh
fi

# A collection of functions to undo accidental git actions
USAGE_UNDO_PUSHED_FILE="$(decorate_stdout --char="#" --msg="Usage: git_undo_push <file_to_undo>")"

function git_undo_push() {
    local file_to_undo
    local check_file
    file_to_undo="$1"

    if [ -z "$file_to_undo" ]; then
        log_error "No file to undo was specified!"
        log_info "$USAGE_UNDO_PUSHED_FILE"

        read -rp "Enter the file to undo: " file_to_undo
    fi

    check_file="$file_to_undo"
    if [ -f "$check_file" ]; then
           git filter-branch --force --index-filter "git rm --cached --ignore-unmatch '$file_to_undo'" --prune-empty --tag-name-filter cat -- --all
        return 0
    else
        log_error "File to undo does not exist: $file_to_undo"
        return 1
    fi
}

alias git_undo_push=git_undo_push
git_undo_push "$@"