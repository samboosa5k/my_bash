#!/bin/bash

if [ -f "$CFG_DIR"/prompt/colorize_stdout.sh ]; then
    . "$CFG_DIR"/prompt/colorize_stdout.sh
fi

ALLOWED_SUBCHARACTER=(
    "-"
    "_"
    ""
)

ALLOWED_IGNORE_PATTERN=(
    "(\.)?(\w+)$"
    "(\.\/)?(\w+)$"
    "(\.\/)?(\w+)$|(\.\/)?(\w+)$"
)

function confirm_action() {
    local prompt_message
    local user_input

    prompt_message="$1"
    read -rp "${prompt_message} (y/n): " user_input
    [[ "$user_input" =~ ^[Yy]$ ]]
}

# rename files and directories loop
function rename_loop() {
    local rename_targets
    local substitute_character

    # main variables
    rename_targets="$1"
    substitute_character="$2"

    # while loop to rename files and directories
    while read -r target; do
        local renamed_target
        local renamed_target_exists

        renamed_target=$(echo "${target}" | sed -E "s/\\s/${substitute_character}/g")
        renamed_target_exists=$(find . -name "${renamed_target}" -maxdepth 1)

        if [[ -n "${renamed_target_exists}" ]]; then
            colorize_stdout "$ERROR_RED" "Target already exists: ${renamed_target}"
            continue
        else
            printf "Renaming %s to %s\n" "${target}" "${renamed_target}"
            colorize_stdout "$INFO_BLUE" "Renaming ${target} to ${renamed_target}"
            mv "${target}" "${renamed_target}" || colorize_stdout "$ERROR_RED" "Failed to rename ${target} to ${renamed_target}"
        fi
    done <<<"${rename_targets}"

    return 0
}

# replace_spaces function
function replace_spaces() {
    local files
    local directories
    local substitute_character
    local join_at_spaces
    local ignore_pattern

    # Parse flags
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --join)
                join_at_spaces=true
                shift
                ;;
            --subchar)
                substitute_character="$2"
                shift 2
                ;;
            --ignore)
                ignore_pattern="$2"
                shift 2
                ;;
            *)
                colorize_stdout "$ERROR_RED" "Unknown flag: $1"
                return 1
                ;;
        esac
    done

    # Check if substitute_character is empty, if it is, join_at_spaces=true
    if [[ -z "$substitute_character" ]]; then
        colorize_stdout "$WARNING_YELLOW" "Substitute character not provided..."
        if confirm_action "Do you want to join at spaces?"; then
            join_at_spaces=true
        else
            read -rp "Enter substitute character: " substitute_character

            # Check if substitute_character is empty again
            if [[ -z "$substitute_character" ]]; then
                colorize_stdout "$ERROR_RED" "Substitute character cannot be empty."
                return 1
            fi

            # Validate substitute character - match input with allowed characters
            local valid_subchar=false
            for subchar in "${ALLOWED_SUBCHARACTER[@]}"; do
                local subchar_match
                subchar_match=$(echo "$substitute_character" | grep -E "$subchar")

                if [[ -n "$subchar_match" && "$valid_subchar" = false ]]; then
                    valid_subchar=true
                    colorize_stdout "$SUCCESS_GREEN" "Using substitute character: ${substitute_character}"
                    break
                fi
            done

            if [[ "$valid_subchar" = false ]]; then
                colorize_stdout "$ERROR_RED" "Invalid substitute character: $substitute_character"
                return 1
            fi
        fi
    fi

    # Check if ignore_pattern has been provided and is not empty
    if [[ -n "$ignore_pattern" ]]; then
        # Validate ignore pattern - match input with allowed patterns
        local valid_ignore_pattern=false
        for pattern in "${ALLOWED_IGNORE_PATTERN[@]}"; do
            local pattern_match
            pattern_match=$(echo "$ignore_pattern" | grep -E "$pattern")

            if [[ -n "$pattern_match" && "$valid_ignore_pattern" = false ]]; then
                valid_ignore_pattern=true
                colorize_stdout "$SUCCESS_GREEN" "Using ignore pattern: ${ignore_pattern}"
                break
            fi
        done

        if [[ "$valid_ignore_pattern" = false ]]; then
            colorize_stdout "$ERROR_RED" "Invalid ignore pattern: $ignore_pattern"
            return 1
        fi
    fi

    # Find files and directories in current directory (maxdepth 1)
    files=$(find . -type f -maxdepth 1 2>/dev/null)
    # Exclude files matching the ignore pattern
    if [[ -n "$ignore_pattern" ]]; then
        files=$(echo "${files}" | grep -vE "$ignore_pattern")
    fi
    directories=$(find . -type d -maxdepth 1 2>/dev/null)
    # Exclude directories matching the ignore pattern
    if [[ -n "$ignore_pattern" ]]; then
        directories=$(echo "${directories}" | grep -vE "$ignore_pattern")
    fi

    # Format output
    term_width=$(tput cols)
    col_width=$((term_width / 2))

    colorize_stdout "$INFO_BLUE" "The following directories and files will be renamed:\n"
    paste <(echo "${directories}") <(echo "${files}") | while IFS=$'\t' read -r dir file; do
        printf "%-${col_width}s %-${col_width}s\n" "Directory: ${dir}" "File: ${file}"
    done

    # If nr of files and directories is 0, skip renaming files
    if [[ -z "$files" ]]; then
        colorize_stdout "$WARNING_YELLOW" "No files found to rename."
    else
        if  confirm_action "Do you want to rename files?"; then
            colorize_stdout "$INFO_BLUE" "Renaming files..."
            rename_loop "${files}" "${substitute_character}"
        else
            colorize_stdout "$WARNING_YELLOW" "Skipping file renaming."
        fi
    fi

    # If nr of directories is 0, skip renaming directories
    if [[ -z "$directories" ]]; then
        colorize_stdout "$WARNING_YELLOW" "No directories found to rename."
    else
        if  confirm_action "Do you want to rename directories?"; then
            colorize_stdout "$INFO_BLUE" "Renaming directories..."
            rename_loop "${directories}" "${substitute_character}"
        else
            colorize_stdout "$WARNING_YELLOW" "Skipping directory renaming."
        fi
    fi

    return 0
}

alias replace_spaces=replace_spaces
replace_spaces "$@"
