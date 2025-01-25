#!/bin/bash

# Color codes
BG_SOLID_BLACK="\e[48;5;0m"
BG_SOLID_RED="\e[48;5;196m"
FG_NEON_ORANGE="\e[38;5;202m"
FG_BOLD="\e[1m"
FG_CYAN="\e[38;5;45m"
FG_WHITE="\e[38;5;15m"
FG_NEON_GREEN="\e[38;5;82m"
RESET="\e[0m"

# Function to format terminal output into a table
# THe table should always fill the terminal width
# The columns should be equally spaced
# The columns should be separated by a pipe character
# The table header should have a cyan background and bold neon orange text
# If one column has more rows than the other, the empty rows should be filled with empty strings

# Usage: format_table --headers="Header1|Header2|Header3" $(ls -a1) $(ls -a1 ./path/to/dir) $(ls -a1 ./path/to/another/dir)
function format_table() {
    # headers for the table
    local headers
    # rows for the table
    local rows
    # total terminal columns
    local total_terminal_columns
    # max width for each column
    local max_width
    # table to be printed
    local table

    # If no arguments are passed, read from the user
    if [ "$#" -eq 0 ]; then
        echo "No arguments provided. Please provide the headers and rows for the table."

        # Read the headers
        read -rp "Enter the headers separated by a pipe character: " headers

        # Read the rows
        read -rp "Enter the rows separated by a space: " rows

    elif [ "$#" -gt 0 ]; then
        # If arguments are passed, parse them
        for arg in "$@"; do
            case $arg in
            --headers=*)
                headers="${arg#*=}"
                shift
                ;;
            *)
                rows+=("$arg")
                shift
                ;;
            esac
        done
    fi

    # Check if the headers are valid
    if [ -z "$headers" ]; then
        echo "Invalid headers. Please provide valid headers."
        return 1
    fi

    # Check if the rows are valid
    if [ -z "$rows" ]; then
        echo "Invalid rows. Please provide valid rows."
        return 1
    fi

    # Get the total terminal columns
    total_terminal_columns=$(tput cols)
    # Calculate the max width for each column
    max_width=$((total_terminal_columns / ${#headers[@]}))
    # Initialize the table
    table="|"

    # Print the headers with a solid background and bold neon orange text
    echo -e "${BG_SOLID_BLACK}${FG_NEON_ORANGE}${FG_BOLD}$headers${RESET}"

    # Add the rows to the table
    for row in "${rows[@]}"; do
        table="$table $(printf "%-${max_width}s" "$row") |"
    done

    # Print the table
    echo -e "$table"
}

# Function to list lossy images (extension should be a parameter, uppercase and lowercase) present in 1 directory, and delete raw files (extension  should be a parameter) which are not present in the jpgs list. Both files should be in the same directory, otherwise a parameter should be provided.
# The goal is to quickly cull jpg's without having to load the raw files slowing down the process.

# Usage: image_delete.sh --reference-dir=/path/to/dir --reference-extension="JPG|jpg" --target-extension="NEF|nef" --target-dir=/path/to/dir

function image_delete() {
    # dir in which to search for the reference files
    local reference_dir
    local reference_extension
    # dir in which to search for the target files
    local target_extension
    local target_dir

    # If no arguments are passed, read from the user
    if [ "$#" -eq 0 ]; then
        echo "No arguments provided. Please provide the reference and target directories, and their respective extensions."

        # Read the reference directory
        read -rp "Enter the reference directory: " reference_dir

        # Read the reference extension
        read -rp "Enter the reference extension (e.g. JPG|jpg): " reference_extension

        # Read the target directory
        read -rp "Enter the target directory: " target_dir

        # Read the target extension
        read -rp "Enter the target extension (e.g. NEF|nef): " target_extension
    elif [ "$#" -gt 0 ]; then
        # If arguments are passed, parse them
        for arg in "$@"; do
            case $arg in
            --reference-dir=*)
                reference_dir="${arg#*=}"
                shift
                ;;
            --reference-extension=*)
                reference_extension="${arg#*=}"
                shift
                ;;
            --target-dir=*)
                target_dir="${arg#*=}"
                shift
                ;;
            --target-extension=*)
                target_extension="${arg#*=}"
                shift
                ;;
            esac
        done
    fi

    # Check if the reference directory is valid
    if [ -z "$reference_dir" ] || [ ! -d "$reference_dir" ]; then
        echo "Invalid reference directory. Please provide a valid reference directory."
        return 1
    fi

    # Check if the reference extension is valid
    if [ -z "$reference_extension" ]; then
        echo "Invalid reference extension. Please provide a valid reference extension."
        return 1
    fi

    # Check if the target directory is valid
    if [ -z "$target_dir" ] || [ ! -d "$target_dir" ]; then
        echo "Invalid target directory. Please provide a valid target directory."
        return 1
    fi

    # Check if the target extension is valid
    if [ -z "$target_extension" ]; then
        echo "Invalid target extension. Please provide a valid target extension."
        return 1
    fi

    # list of matching reference files
    local matching_reference_files
    # list of matching target files
    local matching_target_files
    # list of non-matching files
    local non_matching_files

    # Find the matching reference files
    matching_reference_files=$(find "$reference_dir" -maxdepth 1 -type f -iregex ".*\.\($reference_extension\)")
    # Find the matching target files
    matching_target_files=$(find "$target_dir" -maxdepth 1 -type f -iregex ".*\.\($target_extension\)")
    # Find the non-matching files
    non_matching_files=$(comm -23 <(printf "%s\n" "${matching_target_files[@]}" | sort) <(printf "%s\n" "${matching_reference_files[@]}" | sort))

    # table to be printed
    local results_table

    # Create a table preview with tbe headers "Reference|Target|Non-Matching"
    results_table=$(format_table --headers="Reference|Target|Non-Matching" "${matching_reference_files[@]}" "${matching_target_files[@]}" "${non_matching_files[@]}")

    # Print the table
    echo -e "$results_table"

    # delete confirmation message
    local delete_confirmation_message
    # confirmation to delete the non-matching files
    local confirm_delete

    # Ask for confirmation to delete the non-matching files
    # Full red background with bold white text and length of total files to be deleted
    delete_confirmation_message="${BG_SOLID_RED}${FG_WHITE}${FG_BOLD}Delete ${#non_matching_files[@]} non-matching files? (y/n)${RESET}"
    read -rp "$delete_confirmation_message" confirm_delete

    # if the user does not confirm, exit the function
    if [ "$confirm_delete" != "y" ]; then
        return 0
    fi
    # If the user confirms, delete the non-matching files and print verbose output
    if [ "$confirm_delete" == "y" ]; then
        for file in "${non_matching_files[@]}"; do
            rm -v "$file"
        done
        return 0
    fi
}

alias image_delete=image_delete
image_delete
