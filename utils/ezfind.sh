#!/bin/bash

if [ -f $CFG_DIR/utils/get_type.sh ]; then
    . $CFG_DIR/utils/get_type.sh
fi

# Script to use the "find" command or the "locate" command to search for files
# If a db is not find, one will be created if it doesn't exist

# Check if the user has the "locate" command e.g. macOS
