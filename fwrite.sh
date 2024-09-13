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

    source=$1
    target=$2

    echo "$READING_FILE $source"
    echo "$CONTENTS_BEFORE"
    echo cat "$target"
    echo "$WRITING_FILE $target to $source"
    cat "$source" >"$target"
    echo "$CONTENTS_AFTER"
    cat "$source"

    return 0
}
alias fwrite=fwrite
fwrite "$1" "$2"
