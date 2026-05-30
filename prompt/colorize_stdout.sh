#!/bin/bash

function colorize_stdout() {
    local color
    local message

    color="${1:-$RESET_COLOR}"
    message="$2"

    echo -e "${color}${message}${RESET_COLOR}"
    return 0
}

function log_error() {
    local message

    message="$1"

    colorize_stdout "$ERROR_RED" "$message"
    return 0
}

function log_warning() {
    local message

    message="$1"

    colorize_stdout "$WARNING_YELLOW" "$message"
    return 0
}

function log_info() {
    local message

    message="$1"

    colorize_stdout "$INFO_BLUE" "$message"
    return 0
}

function log_success() {
    local message

    message="$1"

    colorize_stdout "$SUCCESS_GREEN" "$message"
    return 0
}

function log_debug() {
    local message

    message="$1"

    colorize_stdout "$DEBUG_CYAN" "$message"
    return 0
}

function log_custom() {
    local color
    local message

    color="$1"
    message="$2"

    colorize_stdout "$color" "$message"
    return 0
}
