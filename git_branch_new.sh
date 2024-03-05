#!/bin/bash
function untracked_handler() {
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

alias untracked_handler=untracked_handler

function git_branch_new() {
  local branch_list
  local commit_message
  local new_branch
  local source_branch
  local source_is_remote

  new_branch=$1

  # List branches and print index
  branch_list="$(git branch -a | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')"
  branch_list=$(echo "$branch_list" | awk '{print NR-1 " " $0}')

  # If no new branch is provided, print an error message
  if [ -z "$new_branch" ]; then
    echo "No new branch provided"
    return 1
  fi

  # Check if new branch already exists
  echo "Enter source branch index for new branch:"
  echo "$branch_list"

  # Read source branch index
  local idx
  read -r idx

  # Check if index is valid
  if [ -z "$idx" ] || [ "$idx" -gt "$(echo "$branch_list" | wc -l)" ]; then
    echo "Invalid index"
    return 1
  else
    # Check if branch is origin/remote/*
    if [[ "$(echo "$branch_list" | awk -v idx="$idx" 'NR-1==idx {print $2}')" == "origin/"* ]]; then
      source_is_remote=true
    else
      source_is_remote=false
    fi
    # If source branch is remote, make a local copy and set source branch to local copy, otherwise set source branch to the branch name
    if [ "$source_is_remote" == true ]; then
      echo "Source branch is remote"
      source_branch=$(echo "$branch_list" | awk -v idx="$idx" 'NR-1==idx {print $2}' | sed 's/origin\///g')
      echo "Checking out remote branch $source_branch..."
      git checkout -b "$source_branch" "origin/$source_branch"
    else
      echo "Source branch is local"
      # Set source branch
      source_branch=$(echo "$branch_list" | awk -v idx="$idx" 'NR-1==idx {print $2}')
      echo "Source branch set to $source_branch"
    fi
  fi

  untracked_handler

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
      git add . &&
        git commit -m "$commit_message" &&
        git checkout -b "$new_branch"
      return 0
    elif [ "$stash_or_commit_or_discard" == "2" ]; then
      git add . &&
        git stash &&
        git checkout "$source_branch" &&
        untracked_handler
      echo "Pulling from source branch $source_branch..." &&
        git pull &&
        git checkout -b "$new_branch" &&
        echo "Popping to new branch $new_branch..." &&
        git stash pop &&
        git add . &&
        return 0
    elif [ "$stash_or_commit_or_discard" == "3" ]; then
      echo "Discarding changes..."
      git restore . &&
        git checkout -b "$new_branch"
      return 0
    else
      echo "Invalid option"
      return 1
    fi
  else
    echo "No changes found"
    git checkout "$source_branch" &&
      untracked_handler
    git pull &&
      git checkout -b "$new_branch"
    return 0
  fi
}

alias git_branch_new=git_branch_new
git_branch_new "$1"
