#!/bin/bash

if [ -f "$CFG_DIR"/prompt/colorize_stdout.sh ]; then
    . "$CFG_DIR"/prompt/colorize_stdout.sh
fi

function backup(){
    local backup_list
    local backup_source
    local backup_destination

    backup_list="$1"
    backup_source="$2"
    backup_destination="$3"

    log_info "========================================"
    log_info "        PLASMA CONFIG BACKUP TOOL      "
    log_info "========================================"

    log_info "Usage: backup <list of files> <source> <destination>"

    # if source doesn't exist, exit
    if [ -z "$backup_source" ]; then
        log_error "Source directory doesn't exist: $backup_source"
        return 1
    fi

    # if list is empty, exit
    local list_length
    list_length=$(wc -l "$backup_list"| awk '{print $1}')

    if [ "$list_length" -eq 0 ]; then
        log_warning "No files to backup in list: $backup_list"
        return 1
    fi

    # if destination doesn't exist, create it
    if [ ! -d "$backup_destination" ]; then
        mkdir -p "$backup_destination"
        log_info "Destination doesn't exist, creating it: $backup_destination"
    fi

    while read -r line; do
        echo "Backing up $line"
        cp -r "$backup_source/$line" "$backup_destination"
    done < "$1"

    return 0
}

alias backup=backup

# backup all config files
alias backup_config='backup config_list ~/.config/ .config'
