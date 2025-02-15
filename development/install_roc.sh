#!/bin/bash

# Colors
ERROR_RED="\033[0;31m"
SUCCESS_GREEN="\033[0;32m"
INFO_BLUE="\033[0;34m"
RESET_COLOR="\033[0m"

LATEST_RELEASE_URL="https://github.com/roc-lang/roc/releases/download/0.0.0-alpha2-rolling/roc-linux_x86_64-0-alpha2-rolling.tar.gz"

DOWNLOAD_DIR="$HOME/Downloads/temp/"
GLOBAL_DEPS_DIR="$HOME/.local/bin/"

function colorize_stdout() {
  local color
  local message

  color="$1"
  message="$2"

  echo -e "$color$message$RESET_COLOR"
  return 0
}

DIR_EVALUATED_MSG="Is a directory"
FILE_EVALUATED_MSG="Not a directory"
DOES_NOT_EXIST_EVALUATED_MSG="No such file or directory"

function get_type() {
  local target
  local eval_stdout
  local type

  if [ -z "$1" ] || [[ ${#} -gt 1 ]]; then
    type="ERROR"

    colorize_stdout "$ERROR_RED" "Error: Invalid number of arguments"
    colorize_stdout "$INFO_BLUE" "Usage: get_type <target>"

    exit 1
  fi

  target="$1"
  eval_target=$(eval "cd $target")
  eval_stdout=$($eval_target | sed 's/^(.*).+(\:)$//g')

  if [ "$eval_stdout" == "$DIR_EVALUATED_MSG" ]; then
    type="DIRECTORY"
    colorize_stdout "$INFO_BLUE" "Type: $type"
    return $type
  elif [ "$eval_stdout" == "$FILE_EVALUATED_MSG" ]; then
    type="FILE"
    colorize_stdout "$INFO_BLUE" "Type: $type"
    return $type
  elif [ "$eval_stdout" == "$DOES_NOT_EXIST_EVALUATED_MSG" ]; then
    type="DOES_NOT_EXIST"
    colorize_stdout "$INFO_BLUE" "Type: $type"
    return $type
  fi

}

function create_if_not_exists() {
  local target
  local target_type

    if [ -z "$1" ] || [[ ${#} -gt 1 ]]; then
        colorize_stdout "$ERROR_RED" "Error: Invalid number of arguments"
        colorize_stdout "$INFO_BLUE" "Usage: create_if_not_exists <target>"
        exit 1
    fi

    target="$1"
    target_type=$(get_type "$target")

    if [ "$target_type" == "DOES_NOT_EXIST" ]; then
        mkdir -p "$target"
        colorize_stdout "$SUCCESS_GREEN" "Directory created: $target"
    else
        colorize_stdout "$INFO_BLUE" "Directory already exists: $target"
    fi

    return 0
}


function install_roc() {
  local download_dir
  local latest_release_url
  local roc_tarball

  download_dir="$1"
  latest_release_url="$2"
  roc_tarball="$download_dir/roc.tar.gz"

  create_if_not_exists "$download_dir"

  wget -O "$roc_tarball" "$latest_release_url"
  tar -xvf "$roc_tarball" -C "$download_dir"
  mv "$download_dir/roc" "$GLOBAL_DEPS_DIR"

  colorize_stdout "$SUCCESS_GREEN" "Roc installed to $GLOBAL_DEPS_DIR"
  return 0
}

alias install_roc=install_roc
install_roc "$DOWNLOAD_DIR" "$LATEST_RELEASE_URL"