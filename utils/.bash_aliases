#!/bin/bash

# Quickly filter x86_64 packages and no devel
# dnf search poppler | grep -E "^\w+" | sed -E 's/(.+)?devel(.*).+//g' | sed -E 's/(.+)?\.i686(.*).+//g' | sed -E 's/\s:(.+)?//' | grep -E "\S+"

# Quickly create an alias of the current directory
alias bkdir='$CFG_DIR/utils/quick_alias.sh'

# Bulk create symlink directories
alias mklns='$CFG_DIR/utils/bulk_symlink.sh'

# Capture and log command and output to *.md
alias capture='$CFG_DIR/utils/capture.sh'
alias cap='$CFG_DIR/utils/capture.sh'

# Renaming scripts
alias replace_spaces='$CFG_DIR/utils/replace_spaces.sh'
log_success "Rename aliases loaded $happy"

# Overwrite file with content
alias fwrite='$CFG_DIR/utils/fwrite.sh'

# Move files based on criteria
alias fastmove='$CFG_DIR/utils/fastmove.sh'

# Success message
log_success "Utils aliases loaded $happy"

# Navigate like 'cd' but log the location and print useful information
alias to='source $CFG_DIR/utils/navigation.sh'
# Success message
log_success "Navigation aliases loaded $happy"
