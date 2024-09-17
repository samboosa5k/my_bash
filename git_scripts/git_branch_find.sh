#!/bin/bash
function git_branch_find() {
  local query
  local branch_list

  query=$1
  # If no query is provided, print an error message
  if [ -z "$query" ]; then
    echo "No query provided"
    return 1
  fi

  branch_list=$(git branch -a | grep -i "$query" | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')
  branch_list=$(echo "$branch_list" | awk '{print NR-1 " " $0}')
  if [ -z "$branch_list" ]; then
    echo "No branches found"
    return 1
  fi

  # If only one branch is found, check it out
  if [ "$(echo "$branch_list" | wc -l)" -eq 1 ]; then
    git checkout "$(echo "$branch_list" | awk '{print $2}')"
    return 0
  else
    # If multiple branches are found, print them and ask which to check out
    echo "Enter branch index to check out:"
    echo "$branch_list"

    local idx
    read -r idx

    if [ -z "$idx" ]; then
      echo "No index provided"
      echo "Enter target branch index:"
      echo "$branch_list"
      read -r idx
    fi
    git checkout "$(echo "$branch_list" | awk -v idx="$idx" 'NR-1==idx {print $2}')" &&
      return 0
  fi
}

alias git_branch_find=git_branch_find
git_branch_find "$1"
