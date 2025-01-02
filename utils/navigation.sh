#!/bin/bash

# Color codes
BG_SOLID_BLACK="\e[48;5;0m"
FG_NEON_ORANGE="\e[38;5;202m"
FG_BOLD="\e[1m"
FG_CYAN="\e[38;5;45m"
RESET="\e[0m"

# Function to log navigation
function log_navigation() {
    local destination
    local current_location
    local location_log_file

    destination="$1"
    current_location="$PWD"
    location_log_file="$HOME/Logs/location_log.csv"

    if [ -f "$location_log_file" ]; then
        # Print the title with a solid background and bold neon orange text
        echo -e "${BG_SOLID_BLACK}${FG_NEON_ORANGE}${FG_BOLD}Recent Locations${RESET}"
        # Display the last 3 recorded locations with colorized output
        tail -n 3 "$location_log_file" | while IFS= read -r line; do
            echo -e "${FG_CYAN}$line${RESET}"
        done
    else
        # Create the file and add the header
        echo "Location,Destination,Date" >"$location_log_file"
    fi

    # Add the current location, destination, and date to the location log
    echo "$current_location,$destination,$(date)" >>"$location_log_file"
}

alias log_navigation=log_navigation

# Function to list contents in a table format
function list_contents_table() {
    local total_terminal_columns
    local max_width
    local table
    local destination_dirs_10
    local destination_files_10

    total_terminal_columns=$(tput cols)
    max_width=$((total_terminal_columns / 2))
    table="| $(printf "%-${max_width}s" "Folder") | $(printf "%-${max_width}s" "File") |"

    # Print the title with a solid background and bold neon orange text
    echo -e "${BG_SOLID_BLACK}${FG_NEON_ORANGE}${FG_BOLD}Directory Contents${RESET}"

    # Get the first 10 directories and files
    mapfile -t destination_dirs_10 < <(find . -maxdepth 1 -type d -print | head -n 10)
    mapfile -t destination_files_10 < <(find . -maxdepth 1 -type f -print | head -n 10)

    # Add the destination directories and files to the table
    for i in {0..9}; do
        table="$table\n| ${FG_CYAN}$(printf "%-${max_width}s" "${destination_dirs_10[$i]}")${RESET} | ${FG_CYAN}$(printf "%-${max_width}s" "${destination_files_10[$i]}")${RESET} |"
    done

    # Print the table
    echo -e "$table"
}

alias list_contents_table=list_contents_table

# Function to navigate to a directory
function to() {
    local destination

    destination="$1"

    if [ -z "$destination" ]; then
        echo "No destination provided"
        return 0
    fi

    if [ ! -e "$destination" ]; then
        echo "No such file or directory: $destination"
        return 0
    fi

    if [ -d "$destination" ]; then
        # Log the navigation
        log_navigation "$destination"
        # if cd fails, print why
        cd "$destination" || echo "Failed to navigate to $destination"
        # List contents in a table format
        list_contents_table
    elif [ -f "$destination" ]; then
        cd "$(dirname "$destination")" || echo "Failed to navigate to $(dirname "$destination")"
    else
        echo "No such directory: $destination"
    fi
}

alias to=to
to "$1"