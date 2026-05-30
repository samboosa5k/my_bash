#!/bin/bash
# fwrite.sh: Overwrite source ($1) with target ($2).

# STDOUT
READING_FILE="Reading file: "
WRITING_FILE="Writing file: "
CONTENTS_BEFORE="Contents before: "
CONTENTS_AFTER="Contents after: "

function fwrite() {
    local source
    local target
    local is_confirmed

    if [ -z "$1" ]; then
        echo "Usage: fwrite source target"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: source $1 does not exist."
        return 1
    elif [ ! -f "$2" ]; then
        echo "Error: target $2 does not exist."
        return 1
    fi

    source="$1"
    target="$2"

    while true; do
        log_equals_box "Are you sure you want to overwrite $target with $source? (y/n)"
        read -r is_confirmed
        case $is_confirmed in
        [Yy]*)
            break
            ;;
        [Nn]*)
            echo "Operation cancelled"
            return 1
            ;;
        *)
            echo "Please answer y or n"
            ;;
        esac
    done

    echo "$READING_FILE $source"
    echo "$CONTENTS_BEFORE"
    cat "$source"
    echo "$WRITING_FILE $source to $target"
    cat "$source" >"$target"
    echo "$CONTENTS_AFTER"
    cat "$target"

    return 0
}
alias fwrite=fwrite
fwrite "$1" "$2"
