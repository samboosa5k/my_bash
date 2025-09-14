#!/bin/bash

# Decorate stdout with headers filled with ascii characters and colors

EQUALS_ROW="========================================================================================================="
HASHTAG_ROW="########################################################################################################"
TILDE_ROW="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
MINUS_ROW="---------------------------------------------------------------------------------------------------------"
DEFAULT_ROW=$MINUS_ROW

function usage() {
    echo "Error: --msg argument is required." >&2
    echo "  decorate_stdout --char=~ --msg=\"Hello, World!\""
    return 1
}

function decorate_stdout() {
    # message to decorate
    local message=""
    local output_message=""
    # output additional
    local output_top
    local output_bottom
    # filler and padding rows based on
    # formatting basis
    local filler_row=$DEFAULT_ROW
    local padding_row

    # Parse arguments manually for long options
    while [[ $# -gt 0 ]]; do
        case $1 in
        --char=*)
            local char="${1#*=}"
            # assign filler row based on character
            if [ "$char" == "=" ]; then
                filler_row=$EQUALS_ROW
            elif [ "$char" == "#" ]; then
                filler_row=$HASHTAG_ROW
            elif [ "$char" == "~" ]; then
                filler_row=$TILDE_ROW
            elif [ "$char" == "-" ]; then
                filler_row=$MINUS_ROW
            else
                filler_row=$DEFAULT_ROW
            fi
            shift
            ;;
        --msg=*)
            message="${1#*=}"
            shift
            ;;
        *)
            echo "Invalid option: $1" >&2
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
    local nr_message_chars=${#message}

    # Create filler and padding rows based on terminal width
    filler_row=$(printf "%${nr_cols}s" "" | sed "s/./${filler_row:0:1}/g")
    padding_row="${filler_row:0:1}$(printf "%$((nr_cols - 2))s" "")${filler_row:0:1}"

    # output message
    local max_chars_per_row
    max_chars_per_row=$((nr_cols - 4))

    local increment=0
    # Process message in chunks
    while [ $increment -lt "$nr_message_chars" ]; do
        # Extract chunk of message
        local chunk
        local chunk_length
        chunk="${message:$increment:$max_chars_per_row}"
        chunk_length=${#chunk}

        # Calculate padding needed
        local padding_needed
        local padding
        padding_needed=$((max_chars_per_row - chunk_length))
        padding=$(printf "%${padding_needed}s" "")

        # Create row with message chunk
        local message_row
        message_row="${filler_row:0:1} ${chunk}${padding} ${filler_row:0:1}"

        output_message+="$message_row\n"
        increment=$((increment + max_chars_per_row))
    done

    # Create top and bottom rows
    output_top="${filler_row}\n${padding_row}"
    output_bottom="${padding_row}${filler_row}"
    output_message+="$output_bottom"

    echo -e "$output_top"
    echo -e "$output_message"

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
