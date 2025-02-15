#!/bin/bash

# Quickly filter x86_64 packages and no devel
# dnf search poppler | grep -E "^\w+" | sed -E 's/(.+)?devel(.*).+//g' | sed -E 's/(.+)?\.i686(.*).+//g' | sed -E 's/\s:(.+)?//' | grep -E "\S+"

# Quickly create an alias of the current directory
alias bkdir='$CFG_DIR/utils/quick_alias.sh'

# Bulk create symlink directories
alias mklns='$CFG_DIR/utils/bulk_symlink.sh'

# Create index for locate
alias mkidx='$CFG_DIR/utils/create_index.sh'

# Capture and log command and output to *.md
alias capture='$CFG_DIR/utils/capture.sh'
alias cap='$CFG_DIR/utils/capture.sh'

# Renaming scripts
alias super_rename='$CFG_DIR/utils/super_rename.sh'
alias space_rename='$CFG_DIR/utils/space_rename.sh'
echo "Rename aliases loaded $happy"

# Delete scripts
alias image_delete='$CFG_DIR/utils/image_delete.sh'
echo "Delete aliases loaded $chicken"

# Overwrite file with content
alias fwrite='$CFG_DIR/utils/fwrite.sh'

# copy files from 2 directories and 2 extensions to a destination
alias cpcp='$CFG_DIR/utils/compare_and_copy.sh'

# Success message
echo "Utils aliases loaded $happy"

# Navigate like 'cd' but log the location and print useful information
alias to='source $CFG_DIR/utils/navigation.sh'
echo "Navigation aliases loaded $happy"
