#!/bin/bash

function bulk_links() {
    local pattern
    local search_dir # arg flag --search-dir
    local found_files
    local target_symlink_dir

    local test_run

    while [[ $# -gt 0 ]]; do
        case $1 in
        --pattern)
            pattern=$2
            shift
            shift
            ;;
        --search-dir)
            search_dir=$2
            shift
            shift
            ;;
        --symlink-dir)
            target_symlink_dir=$2
            shift
            shift
            ;;
        --test-run)
            test_run=$1
            shift
            ;;
        *)
            echo "Error: Invalid argument $1"
            return 1
            ;;
        esac
    done

    local info_output
    local error_output
    local table_output

    # set info_output template
    info_output="Info: (blue background)\n"
    error_output="Error: (red background)\n"
    table_output="---------------------------------------------\n
                    | Found | File Path | Symlink Dir | Symlink Name |\n
                    ---------------------------------------------\n"

    while [[ -z $pattern ]]; do
        local input_pattern
        read -p "Enter a pattern to search for files: " input_pattern
        pattern=$input_pattern
    done
    if [[ -z $search_dir ]]; then
        search_dir=$(pwd)
    fi
    while [[ -z $target_symlink_dir ]]; do
        local input_symlink_dir
        read -p "Enter a directory to create symlinks: " input_symlink_dir
        target_symlink_dir=$input_symlink_dir
    done

    found_files=$(find $search_dir -maxdepth 4 -type f -name $pattern)
    found_files_count=$(echo $found_files | wc -l)
    info_output+="1. Found $found_files_count files\n"

    echo "Found $found_files_count files"
    local confirm_creation
    read -p "Do you want to create symlinks? (y/n): " confirm_creation
    if [[ $found_files_count -gt 0 ]]; then
        for file in $found_files; do
            local absolute_file_path=$(realpath $file)
            table_output+="| $file | $target_symlink_dir | $(basename $file) |\n"
            table_output+="---------------------------------------------"
            if [[ $confirm_creation == "y" ]]; then
                ln -s $absolute_file_path $target_symlink_dir/$(basename $file)
            else
                echo "Skipped: $absolute_file_path/$(basename $file) ---> $target_symlink_dir/$(basename $file)"
            fi
        done
    fi

    echo -e $info_output
    echo -e $table_output

    return 0
}

alias bulk_links=bulk_links
bulk_links "$@"
