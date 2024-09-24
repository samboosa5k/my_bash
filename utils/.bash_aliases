#!/bin/bash

# Quickly create an alias of the current directory
alias bkdir='$CFG_DIR/quick_alias.sh'

# Capture and log command and output to *.md
alias capture='$CFG_DIR/utils/capture.sh'
alias cap='$CFG_DIR/utils/capture.sh'
alias bkdir='$CFG_DIR/utils/quick_alias.sh'

# Overwrite file with content
alias fwrite='$CFG_DIR/utils/fwrite.sh'

# copy files from 2 directories and 2 extensions to a destination
alias cpcp='$CFG_DIR/utils/compare_and_copy.sh'

# Success message
echo "Utils aliases loaded $happy"
