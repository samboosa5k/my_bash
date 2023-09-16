#!/bin/bash

# 1. Check if there are changes
# 2. If there are changes in the current branch, ask if we should:
#    echo "1. Commit to current branch"
#    echo "2. Stash changes and pop in existing branch"
#   echo "3. Stash changes in current branch"
# 3. If there are no changes in the current branch, switch immediately to existing branch

function git_branch_stashpop_existing() {
  local query
  local branch_list
  local commit_message
  local target_branch

  query=$1

  # List branches including query and print idx as a link
  # remove stars and whitespace
  branch_list=$(git branch -a | grep -i "$query" | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')
  # add idx to each line
  branch_list=$(echo "$branch_list" | awk '{print NR-1 " " $0}')
  # If no branches are found, print an error message
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

    # Check if index is valid
    if [ -z "$idx" ] || [ "$idx" -gt "$(echo "$branch_list" | wc -l)" ]; then
      echo "Invalid index"
      return 1
    else
      target_branch=$(echo "$branch_list" | awk -v idx="$idx" 'NR-1==idx {print $2}')
    fi
  fi

  local add_or_discard
  # Check if untracked files exist
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    echo "Untracked files exist"
    echo "What should we do with untracked files?"
    echo "1. Add"
    echo "2. Discard"
    read -r add_or_discard

    if [ -z "$add_or_discard" ]; then
      echo "No option provided"
      return 1
    else
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
  fi

  local stash_or_commit_or_discard
  # Check if there are changes
  if [ -n "$(git status --porcelain)" ]; then
    echo "There are uncommitted changes"
    echo "What should we do with current changes?"
    echo "1. Commit to current branch"
    echo "2. Stash then pop in new branch"
    echo "3. Stash in current branch"
    read -r stash_or_commit_or_discard

    if [ -z "$stash_or_commit_or_discard" ]; then
      echo "No option provided"
      return 1
    fi

    if [ "$stash_or_commit_or_discard" == "1" ]; then
      echo "Committing changes to current branch..."
      echo "Enter commit message:"
      read -r commit_message
      git commit -m "$commit_message" &&
        git checkout "$target_branch"
    elif [ "$stash_or_commit_or_discard" == "2" ]; then
      echo "Stashing changes and popping to $target_branch..."
      git stash &&
        git checkout "$target_branch" &&
        git stash pop
    elif [ "$stash_or_commit_or_discard" == "3" ]; then
      echo "Stashing changes "
      git stash &&
        git checkout "$target_branch"
    else
      echo "Invalid option"
      return 1
    fi
  fi

  echo "Switched to branch $target_branch"

  return 0
}

alias git_branch_stashpop_existing=git_branch_stashpop_existing
git_branch_stashpop_existing "$1"
