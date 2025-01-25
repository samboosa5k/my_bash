#!/bin/bash

# Function to index  a directory for "locate"

function create_index() {
    local dir_to_index
    local dir_index_db

    # sudo updatedb -U ./ -o photography_2025.db
    while [[ $# -gt 0 ]]; do
        case $1 in
        --dir)
            dir_to_index=$2
            shift
            shift
            ;;
        --db)
            dir_index_db=$2
            shift
            shift
            ;;
        *)
            echo "Error: Invalid argument $1"
            return 1
            ;;
        esac
    done

    if [[ -z $dir_to_index ]]; then
        read -rp "Enter the directory to index: " dir_to_index
    fi

    if [[ -z $dir_index_db ]]; then
        read -rp "Enter the name of the index database: " dir_index_db
    fi

    if [[ -z $dir_to_index ]] || [[ -z $dir_index_db ]]; then
        echo "Invalid directory or database name. Please provide a valid directory and database name."
        return 1
    fi

    # verbose output
    sudo updatedb -U "$dir_to_index" -o "$dir_index_db"
    echo "Index created for $dir_to_index in $dir_index_db"
}

alias create_index=create_index
create_index "$@"
