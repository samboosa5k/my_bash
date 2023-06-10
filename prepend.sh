#!/usr/bin/env bash

# read csv and prepend line numbers

function prepend_line_numbers {
    local input_file="$1"
    local output_file="$2"

    local line_number=1
    while IFS= read -r line; do
        echo "$line_number,$line"
        line_number=$((line_number + 1))
    done < "$input_file" > "$output_file"
}

alias prepend_line_numbers=prepend_line_numbers
prepend_line_numbers $1 $2
