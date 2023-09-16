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
<<<<<<< Updated upstream
  local commit_changes_or_bring_stash
  local pop_stash
=======
  local add_commit_and_or_stashpop
>>>>>>> Stashed changes

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

  # Check if there are changes
<<<<<<< Updated upstream
  if [ -n "$(git status --porcelain)" ]; then
    echo "There are changes in the current branch"
    # Commit current changes or stash and pop to new branch?
    echo "What should we do with current changes?"
    echo "1. Commit to current branch"
    echo "2. Stash changes and pop in new branch"
    echo "3. Stash changes in current branch"
    read -r commit_changes_or_bring_stash

    if [ -z "$commit_changes_or_bring_stash" ]; then
=======
  if [ -n "$(git status --porcelain)" ] || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    echo "There are changes in the current branch"
    # Commit current changes or stash and pop to new branch?
    echo "What should we do with current changes?"
    echo "1. Add & Commit to current branch"
    echo "2. Add & Stash changes, then pop in new branch"
    echo "3. Add & Stash changes in current branch"
    read -r add_commit_and_or_stashpop

    if [ -z "$add_commit_and_or_stashpop" ]; then
>>>>>>> Stashed changes
      echo "No option provided"
      return 1
    fi

<<<<<<< Updated upstream
    if [ "$commit_changes_or_bring_stash" == "1" ]; then
      pop_stash="false"
=======
    if [ "$add_commit_and_or_stashpop" == "1" ]; then
>>>>>>> Stashed changes
      echo "Committing changes to current branch..."
      echo "Enter commit message:"
      read -r commit_message
      git add . &&
<<<<<<< Updated upstream
        git commit -m "$commit_message"
    elif [ "$commit_changes_or_bring_stash" == "2" ]; then
      pop_stash="true"
      echo "Stashing and  popping changes from current branch..."
      git add . &&
        git stash
    else
      pop_stash="false"
      echo "Stashing changes from current branch..."
      git add . &&
        git stash
    fi
  fi

  # Switch to target branch
  git checkout "$target_branch"

  # If pop_stash is true, pop stash
  if [ "$pop_stash" == "true" ]; then
    git stash pop
  fi

=======
        git commit -m "$commit_message" &&
        git checkout "$target_branch"
    elif [ "$add_commit_and_or_stashpop" == "2" ]; then
      echo "Stashing and popping changes from current branch..."
      echo "Enter commit message:"
      read -r commit_message
      git add . &&
        git stash &&
        git checkout "$target_branch" &&
        git stash pop &&
        git add . &&
        git commit -m "$commit_message"
    elif [ "$add_commit_and_or_stashpop" == "3" ]; then
      echo "Stashing changes from current branch..."
      git add . &&
        git stash &&
        git checkout "$target_branch"
    else
      echo "Invalid option"
      return 1
    fi
  fi

>>>>>>> Stashed changes
  echo "Switched to branch $target_branch"

  return 0
}

alias git_branch_stashpop_existing=git_branch_stashpop_existing
git_branch_stashpop_existing "$1"
