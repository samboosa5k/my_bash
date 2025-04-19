#!/bin/bash

# A cheesy easy / save util to move files making a specific criterua to a specific folder in current directory (otherwise make it).

# THere sh ould be no risk of overwriting files, as the script will only move files that match the criteria.

# Criteria lists:
# --by-ext
# --by-name
# --SENSITIVE

function concat_crtieria() {
    local criteria_list=("$@")
    local criteria
    local criteria_string

    for criteria in "${criteria_list[@]}"; do
        criteria_string+="$criteria"
    done

    echo "$criteria_string"
    return 0
}

function fastmove() {
    local target_dir
    local move_args
    local criteria_list

    move_args=("$@")
    criteria_list=()

    for arg in "${move_args[@]}"; do
        if [ "$arg" == "--by-ext" ]; then
            criteria_list+=("ext")
        elif [ "$arg" == "--by-name" ]; then
            criteria_list+=("name")
        elif [ "$arg" == "--SENSITIVE" ]; then
            criteria_list+=("SENSITIVE")
        fi
    done

    local criteria_string
    criteria_string=$(concat_crtieria "${criteria_list[@]}")

    local target_dir
    # if target dir is not provided, make a "moved" directory in current directory
    # if target dir exists prompt move into it or make a new one
    if [ -z "$1" ]; then
        target_dir="moved"
    else
        target_dir="$1"
    fi

    if [ -d "$target_dir" ]; then
        echo "Directory $target_dir already exists. Move files into it? (y/n)"
        read -r move_files
        if [ "$move_files" == "y" ]; then
            echo "Moving files into $target_dir"
        else
            echo "Enter new directory name"
            read -r new_dir
            target_dir="$new_dir"
        fi
    else
        mkdir "$target_dir"
    fi

    local file
    local file_name
    local file_ext
    local file_name_no_ext
    local target_file
    local target_file_name
    local target_file_ext
    local target_file_name_no_ext

    for file in *; do
        if [ -f "$file" ]; then
            file_name=$(basename "$file")
            file_ext="${file_name##*.}"
            file_name_no_ext="${file_name%.*}"

            if [ "$criteria_string" == "ext" ]; then
                target_file="$target_dir/$file_ext"
            elif [ "$criteria_string" == "name" ]; then
                target_file="$target_dir/$file_name_no_ext"
            elif [ "$criteria_string" == "SENSITIVE" ]; then
                target_file="$target_dir/$file_name"
            fi

            mv "$file" "$target_file"
        fi
    done

    return 0
}

alias fastmove=fastmove
fastmove "$@"
