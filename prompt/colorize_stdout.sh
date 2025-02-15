#!/bin/bash

function colorize_stdout() {
    local color
    local message

    color="$1"
    message="$2"

    echo -e "$color$message$RESET_COLOR"
    return 0
}