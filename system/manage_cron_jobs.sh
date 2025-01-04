#!/bin/bash

# Color codes
BG_SOLID_BLACK="\e[48;5;0m"
FG_NEON_ORANGE="\e[38;5;202m"
FG_BOLD="\e[1m"
FG_CYAN="\e[38;5;45m"
RESET="\e[0m"

LOG_FILE="$HOME/Logs/cron_management_log.csv"

# Function to log actions
log_action() {
    local action="$1"
    local cron_job="$2"
    # Create the log file if it doesn't exist
    if [ ! -f "$LOG_FILE" ]; then
        touch "$LOG_FILE"
        echo -e "${FG_BOLD}Date,Action,Cron Job${RESET}" > "$LOG_FILE"
    fi
    # Log the action
    echo -e "$(date),$action,$cron_job" >> "$LOG_FILE"
    # Print the log file
    cat "$LOG_FILE"
}

# Function to add a cron job
add_cron_job() {
    local cron_job="$1"
    (crontab -l; echo "$cron_job") | crontab - || { echo -e "${FG_NEON_ORANGE}Failed to add cron job${RESET}"; return 1; }
    log_action "add" "$cron_job"
}

# Function to remove a cron job
remove_cron_job() {
    local cron_job="$1"
    crontab -l | grep -v "$cron_job" | crontab - || { echo -e "${FG_NEON_ORANGE}Failed to remove cron job${RESET}"; return 1; }
    log_action "remove" "$cron_job"
}

# Function to list cron jobs
list_cron_jobs() {
    crontab -l
}

# Function to manage cron jobs with a TUI
manage_cron_jobs() {
    local should_install_dialog

    if ! command -v dialog &> /dev/null; then
        echo -e "${FG_NEON_ORANGE}dialog command not found. Please install it to use this script.${RESET}"
        # Check if the user wants to install dialog with read
        read -rp "Do you want to install dialog? (y/n): " should_install_dialog
        if [ "$should_install_dialog" = "y" ]; then
            sudo dnf install -y dialog
        else

        exit 1
        fi
    fi

    local choice
    local cron_job

    while true; do
        choice=$(dialog --clear --backtitle "Cron Management" --title "Manage Cron Jobs" \
            --menu "Choose an action" 15 50 4 \
            1 "Add Cron Job" \
            2 "Remove Cron Job" \
            3 "List Cron Jobs" \
            4 "Exit" 3>&1 1>&2 2>&3)

        case $choice in
            1)
                cron_job=$(dialog --inputbox "Enter cron job to add:" 8 40 3>&1 1>&2 2>&3)
                add_cron_job "$cron_job"
                ;;
            2)
                cron_job=$(dialog --inputbox "Enter cron job to remove:" 8 40 3>&1 1>&2 2>&3)
                remove_cron_job "$cron_job"
                ;;
            3)
                list_cron_jobs | dialog --textbox - 20 60
                ;;
            4)
                break
                ;;
        esac
    done
}

alias manage_cron_jobs=manage_cron_jobs
manage_cron_jobs