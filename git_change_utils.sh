#!/bin/bash
function conflict_handler() {
  echo "Checking for conflicts..."
  local add_or_discard
  # Check if untracked files exist
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    echo "Untracked files exist"
    echo "What should we do with untracked files?"
    echo "1. Add"
    echo "2. Discard"
    read -r add_or_discard

    while [ -z "$add_or_discard" ]; do
      echo "No option provided"
      echo "What should we do with untracked files?"
      echo "1. Add"
      echo "2. Discard"
      read -r add_or_discard
    done

    if [ "$add_or_discard" == "1" ]; then
      echo "Adding and stashing untracked files..."
      git add .
    elif [ "$add_or_discard" == "2" ]; then
      echo "Discarding untracked files..."
      git clean -f
    else
      echo "Invalid option"
      return 1
    fi
  fi
  return 0
}

alias conflict_handler=conflict_handler

function git_change_utils() {
  local query
  local branch_list
  local commit_message
  local target_branch

  query=$1

  branch_list=$(git branch -a | grep -i "$query" | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')
  branch_list=$(echo "$branch_list" | awk '{print NR-1 " " $0}')
  if [ -z "$branch_list" ]; then
    echo "No branches found"
    return 1
  fi

  # If only one branch is found set it as target_branch
  if [ "$(echo "$branch_list" | wc -l)" -eq 1 ]; then
    target_branch=$(git branch -a | grep -i "$query" | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')
  else
    # If multiple branches are found, list them and ask for index
    echo "Enter target branch index:"
    echo "$branch_list"

    local idx
    read -r idx

    if [ -z "$idx" ]; then
      echo "No index provided"
      echo "Enter target branch index:"
      echo "$branch_list"
      read -r idx
    fi
    target_branch=$(echo "$branch_list" | awk -v idx="$idx" 'NR-1==idx {print $2}')
  fi

  conflict_handler

  local stash_or_commit_or_discard
  # Check if there are changes
  if [ -n "$(git status --porcelain)" ]; then
    echo "Changes found"
    while [ -z "$stash_or_commit_or_discard" ]; do
      echo "No option provided"
      echo "What should we do with current changes?"
      echo "1. Commit to current branch"
      echo "2. Stash then pop in new branch"
      echo "3. Discard changes"
      read -r stash_or_commit_or_discard
    done

    if [ "$stash_or_commit_or_discard" == "1" ]; then
      echo "Committing changes to current branch..."
      echo "Enter commit message:"
      read -r commit_message
      git commit -m "$commit_message" &&
      git checkout "$target_branch"
      return 0
    elif [ "$stash_or_commit_or_discard" == "2" ]; then
      echo "Stashing changes and popping to $target_branch..."
      git add . &&
      git stash &&
      git checkout "$target_branch" &&
      conflict_handler
      git stash pop &&
      git add . &&
      return 0
    elif [ "$stash_or_commit_or_discard" == "3" ]; then
      echo "Discarding changes..."
      git restore . &&
      git checkout "$target_branch"
      return 0
    else
      echo "Invalid option"
      return 1
    fi
  else
    echo "No changes to commit"
    git checkout "$target_branch"
    return 0
  fi
}

alias git_change_utils=git_change_utils
git_change_utils "$1"
