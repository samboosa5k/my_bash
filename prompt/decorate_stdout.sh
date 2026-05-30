#!/bin/bash

# Decorate stdout with headers filled with ascii characters and colors

EQUALS_ROW="="
HASHTAG_ROW="#"
TILDE_ROW="~"
MINUS_ROW="-"
DEFAULT_ROW="-"

function usage() {
    echo "Error: --msg argument is required." >&2
    echo "  decorate_stdout --char=~ --msg=\"Hello, World!\""
    return 1
}

function decorate_stdout() {
    # message to decorate
    local message=""
    local char="-"
    
    # Parse arguments manually for long options
    while [[ $# -gt 0 ]]; do
        case $1 in
        --char=*)
            char="${1#*=}"
            shift
            ;;
        --msg=*)
            message="${1#*=}"
            shift
            ;;
        *)
            # If not a long option, assume it's the message if not already set
            if [[ -z "$message" ]]; then
                message="$1"
            fi
            shift
            ;;
        esac
    done

    if [[ -z $message ]]; then
        usage
        return 1
    fi

    # Get terminal width
    local nr_cols
    nr_cols=$(tput cols 2>/dev/null || echo 80)
    # Ensure nr_cols is at least 20 for safety
    if [[ $nr_cols -lt 20 ]]; then nr_cols=80; fi

    local max_chars_per_row=$((nr_cols - 4))
    local border_char="${char:0:1}"
    
    # Create filler and padding rows
    local filler_row
    filler_row=$(printf "%${nr_cols}s" "" | tr ' ' "$border_char")
    local padding_row
    padding_row="${border_char}$(printf "%$((nr_cols - 2))s" "")${border_char}"

    # Start output
    echo -e "${filler_row}"
    echo -e "${padding_row}"

    # Process message in chunks (handling newlines in message too)
    local line
    echo "$message" | while IFS= read -r line || [[ -n "$line" ]]; do
        local nr_line_chars=${#line}
        local increment=0
        
        if [[ $nr_line_chars -eq 0 ]]; then
             echo -e "${border_char} $(printf "%${max_chars_per_row}s" "") ${border_char}"
             continue
        fi

        while [ $increment -lt "$nr_line_chars" ]; do
            local chunk="${line:$increment:$max_chars_per_row}"
            local chunk_length=${#chunk}
            local padding_needed=$((max_chars_per_row - chunk_length))
            local padding=""
            if [ $padding_needed -gt 0 ]; then
                padding=$(printf "%${padding_needed}s" "")
            fi

            echo -e "${border_char} ${chunk}${padding} ${border_char}"
            increment=$((increment + max_chars_per_row))
        done
    done

    echo -e "${padding_row}"
    echo -e "${filler_row}"

    return 0
}

alias decorate_stdout=decorate_stdout

function log_equals_box() {
    local message="$1"
    decorate_stdout --char="=" --msg="$message"
    return 0
}

function log_hashtag_box() {
    local message="$1"
    decorate_stdout --char="#" --msg="$message"
    return 0
}

function log_tilde_box() {
    local message="$1"
    decorate_stdout --char="~" --msg="$message"
    return 0
}

function log_dash_box() {
    local message="$1"
    decorate_stdout --char="-" --msg="$message"
    return 0
}
