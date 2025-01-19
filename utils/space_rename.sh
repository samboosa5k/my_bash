#!/bin/bash

# Simple util to rename files or folders in a directory by replacing spaces with underscores or dashes or user input

function space_rename(){
  local separator

  # read user input for separator,  only  allow dash or underscore
  read -rp "Enter the separator (dash or underscore): " separator

  # check if the separator is valid
  if [ "$separator" != "-" ] && [ "$separator" != "_" ]; then
    echo "Invalid separator. Please provide a valid separator."
    return 1
  fi

  # find the target directories or files and print a list of before and after, prompt for confirmation
  local query_result_list

  # the files should be globbed per row so that e.g. "./RGB 2.4G Rainy 75-2.4G.JSON " is handled as a single file
  IFS=$'\n'

  # Debug output to see what find is doing
  echo "Running find command to locate files with spaces in their names..."
  query_result_list=$(find . -maxdepth 1 -name "* *" -o -name "*$(echo -e '\u00A0')*")
  echo "Find command output:"
  echo "$query_result_list"

  # Check if the result list is empty
  if [ -z "$query_result_list" ]; then
    echo "No matching files found."
    return 1
  fi

  # Print the list of files before and after renaming, formatted as a table with equal column width
  # before is colored red, after is colored green
  # all spaces are replaced with the separator
  echo "Before renaming:"
  for file in $query_result_list; do
    new_file="${file// /$separator}"
    new_file="${new_file//\u00A0/$separator}"  # Replace non-breaking spaces
    printf "\e[31m%-50s\e[0m\e[32m%-50s\e[0m\n" "$file" "$new_file"
  done

  local confirm
  # Prompt for confirmation
  read -rp "Do you want to rename the files? (y/n): " confirm

  # Check if the user confirmed
  if [ "$confirm" != "y" ]; then
    echo "Operation cancelled."
    return 1
  fi

  # Rename the files - verbose mode, all spaces per filename row are replaced with the separator
  # e.g. "./RGB 2.4G Rainy 75-2.4G.JSON " will be renamed to "./RGB-2.4G-Rainy-75-2.4G.JSON" if the separator is a dash
  # the files should be globbed per row so that e.g. "./RGB 2.4G Rainy 75-2.4G.JSON " is handled as a single file
  # the output should be colorized to show the before and after filenames
  for file in $query_result_list; do
    new_file="${file// /$separator}"
    new_file="${new_file//\u00A0/$separator}"  # Replace non-breaking spaces
    mv "$file" "$new_file"
    printf "\e[31m%-50s\e[0m\e[32m%-50s\e[0m\n" "$file" "$new_file"
  done

  echo "Files renamed successfully."
  return 0
}

alias space_rename=space_rename
space_rename "$@"