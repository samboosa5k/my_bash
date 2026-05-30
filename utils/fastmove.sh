#!/bin/bash

# A cheesy easy / save util to move files making a specific criterua to a specific folder in current directory (otherwise make it).

# THere sh ould be no risk of overwriting files, as the script will only move files that match the criteria.

# Criteria lists:
# --by-ext
# --by-name
# --SENSITIVE

function concat_criteria() {
    local criteria_list=("$@")
    local criteria
    local criteria_string=""

    for criteria in "${criteria_list[@]}"; do
        criteria_string+="$criteria"
    done

    echo "$criteria_string"
    return 0
}

function fastmove() {
    local target_dir=""
    local criteria_list=()
    local arg

    for arg in "$@"; do
        if [ "$arg" == "--by-ext" ]; then
            criteria_list+=("ext")
        elif [ "$arg" == "--by-name" ]; then
            criteria_list+=("name")
        elif [ "$arg" == "--SENSITIVE" ]; then
            criteria_list+=("SENSITIVE")
        elif [[ ! "$arg" =~ ^-- ]]; then
            target_dir="$arg"
        fi
    done

    local criteria_string
    criteria_string=$(concat_criteria "${criteria_list[@]}")

    if [ -z "$criteria_string" ]; then
        echo "Error: No criteria provided. Use --by-ext, --by-name, or --SENSITIVE."
        return 1
    fi

    if [ -z "$target_dir" ]; then
        target_dir="moved"
    fi

    if [ -d "$target_dir" ]; then
        echo "Directory $target_dir already exists. Move files into it? (y/n)"
        read -r move_files
        if [ "$move_files" != "y" ]; then
            echo "Enter new directory name:"
            read -r new_dir
            target_dir="$new_dir"
            [ -z "$target_dir" ] && return 1
            mkdir -p "$target_dir"
        fi
    else
        mkdir -p "$target_dir"
    fi

    local file
    local file_name
    local file_ext
    local file_name_no_ext
    local target_path

    for file in *; do
        [ -f "$file" ] || continue
        [ "$file" == "$target_dir" ] && continue
        
        file_name=$(basename "$file")
        file_ext="${file_name##*.}"
        file_name_no_ext="${file_name%.*}"

        if [ "$criteria_string" == "ext" ]; then
            mkdir -p "$target_dir/$file_ext"
            target_path="$target_dir/$file_ext/$file_name"
        elif [ "$criteria_string" == "name" ]; then
            mkdir -p "$target_dir/$file_name_no_ext"
            target_path="$target_dir/$file_name_no_ext/$file_name"
        elif [ "$criteria_string" == "SENSITIVE" ]; then
            target_path="$target_dir/$file_name"
        else
            continue
        fi

        mv "$file" "$target_path"
    done

    return 0
}

alias fastmove=fastmove
fastmove "$@"
