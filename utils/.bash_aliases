#!/bin/bash

# Quickly create an alias of the current directory
alias bkdir='$CFG_DIR/quick_alias.sh'

# Capture and log command and output to *.md
alias capture='$CFG_DIR/capture.sh'
alias cap='$CFG_DIR/capture.sh'

# Overwrite file with content
alias fwrite='$CFG_DIR/fwrite.sh'

# Success message
echo "Utils aliases loaded $happy"
