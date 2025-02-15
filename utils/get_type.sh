#!/bin/bash

DIR_EVALUATED_MSG="Is a directory"
FILE_EVALUATED_MSG="Not a directory"
DOES_NOT_EXIST_EVALUATED_MSG="No such file or directory"

function is_type() {
    local function_list
    local directory_list
    local alias_list
    local file_list
    local target
    local target_path
    local target_type

    target="$1"
    target_path="$2"

    if [ -z "$target" ] || [[ ${#} -gt 1 ]]; then
        colorize_stdout "$ERROR_RED" "Error: Invalid number of arguments"
        colorize_stdout "$INFO_BLUE" "Usage: is_type <target>"

        exit 1
    fi

    cd "$target_path"
    function_list=$(compgen -A function)
    directory_list=$(compgen -A directory)
    alias_list=$(compgen -A alias)
    file_list=$(compgen -A file)

    if [[ " ${function_list[@]} " =~ " $target " ]]; then
        target_type="FUNCTION"
        colorize_stdout "$INFO_BLUE" "Type: $target_type"
        return $target_type
    elif [[ " ${directory_list[@]} " =~ " $target " ]]; then
        target_type="DIRECTORY"
        colorize_stdout "$INFO_BLUE" "Type: $target_type"
        return $target_type
    elif [[ " ${alias_list[@]} " =~ " $target " ]]; then
        target_type="ALIAS"
        colorize_stdout "$INFO_BLUE" "Type: $target_type"
        return $target_type
    elif [[ " ${file_list[@]} " =~ " $target " ]]; then
        target_type="FILE"
        colorize_stdout "$INFO_BLUE" "Type: $target_type"
        return $target_type
    else
        target_type="DOES_NOT_EXIST"
        colorize_stdout "$INFO_BLUE" "Type: $target_type"
        return $target_type
    fi
}

function get_type() {
    local target
    local target_path
    local eval_stdout
    local type

    if [ -z "$1" ] || [[ ${#} -gt 1 ]]; then
        type="ERROR"

        colorize_stdout "$ERROR_RED" "Error: Invalid number of arguments"
        colorize_stdout "$INFO_BLUE" "Usage: get_type <target>"

        exit 1
    fi

    target="$1"
    target_path=$(echo "$target" | sed 's/\/[^/]*$//')

    type=$(is_type "$target" "$target_path")
    echo "$type"
    return 0
}
