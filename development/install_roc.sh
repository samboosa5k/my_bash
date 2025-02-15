#!/bin/bash

if [ -f "$CFG_DIR"/prompt/colorize_stdout.sh ]; then
    . "$CFG_DIR"/prompt/colorize_stdout.sh
fi

if [ -f "$CFG_DIR"/utils/create_if_not_exists.sh ]; then
    . "$CFG_DIR"/utils/create_if_not_exists.sh
fi

if [ -f "$CFG_DIR"/utils/get_type.sh ]; then
    . "$CFG_DIR"/utils/get_type.sh
fi

LATEST_RELEASE_URL="https://github.com/roc-lang/roc/releases/download/0.0.0-alpha2-rolling/roc-linux_x86_64-0-alpha2-rolling.tar.gz"
OUTPUT_NAME="roc-nightly"

function install_roc() {
    local download_dir
    local download_url
    local roc_tarball

    download_dir="$1"
    download_url="$2"
    roc_tarball="$download_dir/roc.tar.gz"

    colorize_stdout "$INFO_BLUE" "Downloading Roc from $download_url"
    colorize_stdout "$INFO_BLUE" "Extracting to $download_dir"
    colorize_stdout "$INFO_BLUE" "Moving Roc to $LOCAL_BINS"

    create_if_not_exists "$download_dir"

    wget -O "$roc_tarball" "$download_url"
    tar -xvf "$roc_tarball" -C "$download_dir"

    local extracted_dir
    extracted_dir="$(find "$download_dir" -type d -name "roc*")"
    mv "$extracted_dir" "$OUTPUT_NAME"
    mv "$OUTPUT_NAME" "$LOCAL_SHARES/$OUTPUT_NAME"
    rm -rf "$download_dir"

    colorize_stdout "$SUCCESS_GREEN" "Roc installed to $LOCAL_SHARES"
    return 0
}

alias install_roc=install_roc
install_roc "$TEMP_DOWNLOADS" "$LATEST_RELEASE_URL"
