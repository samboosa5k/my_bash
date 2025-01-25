#!/bin/bash

# Color codes
BG_SOLID_BLACK="\e[48;5;0m"
FG_NEON_ORANGE="\e[38;5;202m"
FG_BOLD="\e[1m"
FG_CYAN="\e[38;5;45m"
RESET="\e[0m"

function bulk_links() {
    local pattern
    local search_dir    # arg flag --search-dir
    local found_targets # directories and/or files
    local depth
    local target_symlink_dir

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
        --depth)
            depth=$2
            shift
            shift
            ;;
        *)
            echo "Error: Invalid argument $1"
            return 1
            ;;
        esac
    done

    #  if no arguments are passed, read from the user

    if [ -z "$pattern" ]; then
        read -rp "Enter the pattern to search for: " pattern
    fi

    if [ -z "$search_dir" ]; then
        read -rp "Enter the directory to search in: " search_dir
    fi

    if [ -z "$target_symlink_dir" ]; then
        read -rp "Enter the target symlink directory: " target_symlink_dir
    fi

    if [ -z "$depth" ]; then
        read -rp "Enter the depth to search in: " depth
    fi

    #  validate and check if all the arguments exist or are valid

    if [ -z "$pattern" ] || [ -z "$search_dir" ] || [ -z "$target_symlink_dir" ] || [ -z "$depth" ]; then
        echo "Invalid arguments. Please provide valid arguments."
        return 1
    fi

    found_targets=$(find "$search_dir" -maxdepth "$depth" -iname "*$pattern*")

    echo -e "${FG_NEON_ORANGE}Found ${#found_targets[@]} targets${RESET}"

    # if directory to create the symlinks does not exist, create it
    if [ ! -d "$target_symlink_dir" ]; then
        echo -e "${FG_NEON_ORANGE}Creating directory $target_symlink_dir${RESET}"
        mkdir -p "$target_symlink_dir"
    fi

    # Create the symlinks, relative to the target symlink directory
    for result in $found_targets; do
        echo -e "${FG_NEON_ORANGE}Creating symlink $result${RESET}"
        ln -rs "$result" "$target_symlink_dir/$(basename "$result")"
    done
}

alias bulk_links=bulk_links
bulk_links "$@"
