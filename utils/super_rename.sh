#!/bin/bash

# Color codes
BG_SOLID_BLACK="\e[48;5;0m"
FG_NEON_ORANGE="\e[38;5;202m"
FG_BOLD="\e[1m"
FG_CYAN="\e[38;5;45m"
FG_NEON_GREEN="\e[38;5;82m"
RESET="\e[0m"

# Function to rename directories or files based on a fuzzy query

# Goal is to to rename directories with simple sed replacement
# step 1: for dname in $(ls -a1 | grep '2024-12-'); do mv $dname $(echo $dname | sed -E 's/(2024-12-)//'); done
# step 2: for nnn in $(lsd | grep -E '^[0-9]{2}/'); do mv $nnn $(echo $nnn | sed -E 's/\//-12-2024/'); done

function super_rename() {
  # target type argument e.g. '--type=dir' or '--type=file' or '--type=both'
  local rename_target_type
  local fuzzy_query
  # delimiter to flip the string sequence e.g. '_' or '-' 
  local flip_delimiter
  
  # If no arguments are passed, read from the user
  if [ "$#" -eq 0 ]; then
    echo "No arguments provided. Please provide the target type and query."
    
    # Read the target type
    read -rp "Enter the target type (dir, file, both): " rename_target_type
    
    # Read the query
    read -rp "Enter the query: " fuzzy_query
  
  elif [ "$#" -gt 0 ]; then
    # If arguments are passed, parse them
    for arg in "$@"; do
      case $arg in
      --type=*)
        rename_target_type="${arg#*=}"
        shift
        ;;
      --query=*)
        fuzzy_query="${arg#*=}"
        shift
        ;;
      --delimiter=*)
        flip_delimiter="${arg#*=}"
        shift
        ;;
      esac
    done
  fi
  
  # Check if the target type is valid
  if [ "$rename_target_type" != "dir" ] && [ "$rename_target_type" != "file" ] && [ "$rename_target_type" != "both" ]; then
    echo "Invalid target type. Please provide a valid target type."
    return 1
  fi
  
  # Check if the query is valid
  if [ -z "$fuzzy_query" ]; then
    echo "Invalid query. Please provide a valid query."
    return 1
  fi
  
  # find the target directories or files
  local query_result_list
  
  if [ "$rename_target_type" == "dir" ]; then
    query_result_list=$(find . -maxdepth 1 -type d -name "*$fuzzy_query*")
  elif [ "$rename_target_type" == "file" ]; then
    query_result_list=$(find . -maxdepth 1 -type f -name "*$fuzzy_query*")
  elif [ "$rename_target_type" == "both" ]; then
    query_result_list=$(find . -maxdepth 1 -name "*$fuzzy_query*")
  fi
  
  # Check if the result list is empty
  if [ -z "$query_result_list" ]; then
    echo "No matching $rename_target_type found."
    return 1
  fi

  # display a preview of the result of the renaming, colorized using the # Color codes
  # Example: 
  # Table headers: | Old Name | New Name |
  local preview_renamed_list
  local new_name_list

  for result in $query_result_list; do
    local intermediate_string
    local matched_query_string
    local extension=""
    local new_name

    # Check if the result is a file and extract the extension
    if [ -f "$result" ]; then
      extension=$(echo "$result" | sed -E "s/.*\.([a-zA-Z0-9]+)$/\1/")
      intermediate_string=$(echo "$result" | sed -E "s/(.*)\.$extension/\1/")
    else
      intermediate_string="$result"
    fi

    # Get the result string with the query removed
    intermediate_string=$(echo "$intermediate_string" | sed -E "s/($fuzzy_query)//")
    # Get the matched query which will be flipped
    matched_query_string=$(echo "$result" | grep -o "$fuzzy_query")

    # Split the matched query string using the flip delimiter
    local split_matched_query_string
    split_matched_query_string=$(echo "$matched_query_string" | tr "$flip_delimiter" '\n')

    # Flip the split matched query string
    local flipped_matched_query_string
    flipped_matched_query_string=$(echo "$split_matched_query_string" | tac | tr '\n' "$flip_delimiter")

    # Combine the intermediate string and the flipped matched query string
    new_name="${intermediate_string}${flipped_matched_query_string}"

    # Add the extension back if it was a file
    if [ -n "$extension" ]; then
      new_name="${new_name}.${extension}"
    fi

    # Add the new name to the new name list
    new_name_list="${new_name_list}\n${new_name}"

    # Add the old name and new name to the preview
    preview_renamed_list="${preview_renamed_list}\n| ${FG_CYAN}$(basename "$result")${RESET} | ${FG_NEON_GREEN}${new_name}${RESET} |"
  done

  # Print the preview
  echo -e "${BG_SOLID_BLACK}${FG_NEON_ORANGE}${FG_BOLD}Preview Renamed List${RESET}"
  
  # Print the table headers
  echo -e "| ${FG_BOLD}Old Name${RESET} | ${FG_BOLD}New Name${RESET} |"
  
  # Print the preview renamed list
  echo -e "$preview_renamed_list"
  
  # Ask the user if they want to proceed with the renaming
  local should_proceed
  read -rp "Do you want to proceed with the renaming? (y/n): " should_proceed
  
  if [ "$should_proceed" != "y" ]; then
    echo "Exiting..."
    return 0
  fi

  local not_renamed_list

  for i in $(seq 0 $((${#query_result_list[@]} - 1))); do
    local old_name
    local new_name

    old_name="${query_result_list[$i]}"
    new_name="${new_name_list[$i]}"

    if [ -e "$new_name" ]; then
      not_renamed_list="$not_renamed_list\n$new_name"
    else
      mv "$old_name" "$new_name"
    fi
  done

  # if the $not_renamed_list is empty, print a success message colorized using the color codes
  # If it is not empty, print a message with the list of directories or files that were not renamed
  if [ -z "$not_renamed_list" ]; then
    echo -e "${FG_NEON_GREEN}All directories or files have been renamed successfully.${RESET}"
  else
    echo -e "${FG_NEON_ORANGE}The following directories or files could not be renamed:${RESET}"
    echo -e "$not_renamed_list"
  fi

  return 0
}

alias super_rename=super_rename
super_rename "$@"