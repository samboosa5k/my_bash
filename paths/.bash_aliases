#!/bin/bash

# Exported paths

export PATH=$HOME/.local/bin:$PATH

# ROC paths
export PATH="$PATH:$HOME/_WEB/roc_nightly-linux_x86_64-2024-11-15-8dbc909"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Success message
echo "Paths aliases loaded $chicken"