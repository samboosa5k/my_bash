#!/bin/bash

WEB_PATH="$HOME/_WEB"
DOWNLOAD_URL="https://github.com/roc-lang/roc/releases/download/nightly/roc_nightly-linux_x86_64-latest.tar.gz"
DOWNLOADS_HOME="$WEB_PATH"
BASHRC_PATH="$CFG_DIR/.bashrc"

# The extracted dir should be the latest one
function get_latest_extracted_dir() {
    local extracted_dir
    extracted_dir=$(find "$WEB_PATH" -maxdepth 1 -type d -name "roc_nightly-linux_x86_64-*" | sort | tail -n 1)
    echo "$extracted_dir"
}

# Function to update ROC binary
function update_roc() {
    local archive_exists
    local extracted_dir

    # Download the latest nightly build
    echo "Downloading the latest ROC nightly build..."

    # If the archive already exists, delete it
    if [ -f "$DOWNLOADS_HOME/roc_nightly-linux_x86_64-latest.tar.gz" ]; then
        archive_exists=true
        rm "$DOWNLOADS_HOME/roc_nightly-linux_x86_64-latest.tar.gz"
    fi

    # Download the archive
    wget -P "$DOWNLOADS_HOME" "$DOWNLOAD_URL"

    # Extract the archive
    echo "Extracting the archive..."
    tar -xf "$DOWNLOADS_HOME/roc_nightly-linux_x86_64-latest.tar.gz" -C "$DOWNLOADS_HOME"

    # Find the latest extracted directory
    extracted_dir=$(get_latest_extracted_dir)

    # Update the PATH variable
    echo "Updating the PATH variable..."
    export PATH="$PATH:$extracted_dir"

    # Print success message
    echo "ROC nightly build has been updated and PATH variable has been set."

    # Optionally, you can add the PATH update to .bashrc to make it persistent
    echo "export PATH=\$PATH:$extracted_dir" >> "$BASHRC_PATH"
    echo "PATH update has been added to $BASHRC_PATH for persistence."

    # Clean up
    rm "$DOWNLOADS_HOME/roc_nightly-linux_x86_64-latest.tar.gz"
    echo "Clean up completed."

    # Reload .bashrc
    source "$BASHRC_PATH"
    echo "Reloaded $BASHRC_PATH to apply changes."
}

alias update_roc=update_roc
update_roc
