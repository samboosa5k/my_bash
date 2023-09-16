#!/bin/bash
function git_branch_new() {
  local branch_list
  local commit_message
  local source_branch
  local new_branch
  local commit_changes_or_bring_stash
  local pop_stash

  new_branch=$1

  # If no new branch is provided, print an error message
  if [ -z "$new_branch" ]; then
    echo "No new branch provided"
    return 1
  fi

  # List branches and print index
  branch_list="$(git branch -a | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')"
  branch_list=$(echo "$branch_list" | awk '{print NR-1 " " $0}')

  # Check if there are changes
  if [ -n "$(git status --porcelain)" ]; then
    echo "There are changes in the current branch"
    # Commit current changes or stash and pop to new branch?
    echo "What should we do with current changes?"
    echo "1. Commit to current branch"
    echo "2. Stash changes and pop in new branch"
    echo "3. Stash changes in current branch"
    read -r commit_changes_or_bring_stash

    if [ -z "$commit_changes_or_bring_stash" ]; then
      echo "No option provided"
      return 1
    fi

    if [ "$commit_changes_or_bring_stash" == "1" ]; then
      pop_stash="false"
      echo "Committing changes to current branch..."
      echo "Enter commit message:"
      read -r commit_message
      git add . &&
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

  echo "Enter source branch index for new branch:"
  echo "$branch_list"

  # Read source branch index
  local idx
  read -r idx

  # Check if index is valid
  if [ -z "$idx" ] || [ "$idx" -gt "$(echo "$branch_list" | wc -l)" ]; then
    echo "Invalid index"
    return 1
  fi

  # Set source branch
  source_branch=$(echo "$branch_list" | awk -v idx="$idx" 'NR-1==idx {print $2}')

  if [ -z "$source_branch" ]; then
    echo "No source branch provided"
    return 1
  else
    echo "Source branch: $source_branch"
  fi

  # Now git add, git stash if required, git checkout source branch, git pull, git checkout new branch, git stash pop if required
  if [ "$pop_stash" == "true" ]; then
    git add . &&
      git stash &&
      git checkout "$source_branch" &&
      git pull &&
      git checkout -b "$new_branch" &&
      git stash pop &&
      echo "Switched to branch: $new_branch" &&
      return 0
  else
    git add . &&
      git checkout "$source_branch" &&
      git pull &&
      git checkout -b "$new_branch" &&
      echo "Switched to branch: $new_branch" &&
      return 0
  fi
}

alias git_branch_new=git_branch_new
git_branch_new "$1"
