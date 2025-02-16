#!/bin/bash

if [ -f "$CFG_DIR"/prompt/colorize_stdout.sh ]; then
    . "$CFG_DIR"/prompt/colorize_stdout.sh
fi

if [ -f "$CFG_DIR"/utils/get_type.sh ]; then
    . "$CFG_DIR"/utils/get_type.sh
fi

ROC_BASIC_CLI_REPO="https://github.com/roc-lang/basic-cli.git"
ROC_BASIC_CLI_DIR="basic-cli"

function clone_roc_basic_cli() {
    local my_bash_dir
    local roc_basic_cli_dir

    my_bash_dir="$CFG_DIR"
    roc_basic_cli_dir="$CFG_DIR"

    local is_folder
    is_folder=$(is_folder "$CFG_DIR/$roc_basic_cli_dir")

    if [ "$is_folder" == "EXISTS" ]; then
        log_error "Directory already exists: $roc_basic_cli_dir"
    fi

    log_info "Cloning roc basic cli to $roc_basic_cli_dir"

    cd "$CFG_DIR"
    git submodule add $ROC_BASIC_CLI_REPO

    git push origin trunk -v
}
