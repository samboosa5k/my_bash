#!/bin/bash
function git_branch_find() {
  local query
  local result

  query=$1
  # If no query is provided, print an error message
  if [ -z "$query" ]; then
    echo "No query provided"
    return 1
  fi

  result=$(git branch -a | grep -i "$query" | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')
  result=$(echo "$result" | awk '{print NR-1 " " $0}')
  if [ -z "$result" ]; then
    echo "No branches found"
    return 1
  fi

  # If only one branch is found, check it out
  if [ "$(echo "$result" | wc -l)" -eq 1 ]; then
    git checkout "$(echo "$result" | awk '{print $2}')"
    return 0
  fi
  # If multiple branches are found, print them and ask which to check out
  echo "$result"
  echo "Which branch should we checkout? (enter index)"
  local idx
  read -r idx
  git checkout "$(echo "$result" | awk -v idx="$idx" 'NR-1==idx {print $2}')" &&
  return 0
}

alias git_branch_find=git_branch_find
git_branch_find "$1"
