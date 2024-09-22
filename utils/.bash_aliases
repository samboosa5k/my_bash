#!/bin/bash

# Quickly create an alias of the current directory
alias bkdir='$CFG_DIR/quick_alias.sh'

# Capture and log command and output to *.md
alias capture='$CFG_DIR/utils/capture.sh'
alias cap='$CFG_DIR/utils/capture.sh'
alias bkdir='$CFG_DIR/utils/quick_alias.sh'

# Overwrite file with content
alias fwrite='$CFG_DIR/utils/fwrite.sh'

# Success message
echo "Utils aliases loaded $happy"
