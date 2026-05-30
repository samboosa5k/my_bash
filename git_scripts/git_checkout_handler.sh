#!/bin/bash

chicken="🐤"
kitty="🐱"
unhappy="😞"
happy="😀"
sad="😢"
thinking="🤔"
angry="😡"

function checkout_branch_handler() {
  local query=$1
  local branch_list
  local local_branch_list
  local remote_branch_list

  # List branches, clean up, and separate local and remote
  local_branch_list=$(git branch --list "*$query*" | sed 's/[* ]//g')
  remote_branch_list=$(git branch -r --list "*origin/*$query*" | sed 's/origin\///g' | sed 's/ //g')

  if [ -z "$local_branch_list" ] && [ -z "$remote_branch_list" ]; then
    echo "No branches found matching '$query' $unhappy"
    return 1
  fi

  local selected_branch=""

  # Logic for selection
  if [ -n "$local_branch_list" ] && [ -n "$remote_branch_list" ]; then
    echo "Branches found in both local and remote $thinking:"
    echo "Local:"
    echo "$local_branch_list" | awk '{print "  L: " $1}'
    echo "Remote:"
    echo "$remote_branch_list" | awk '{print "  R: " $1}'
    
    echo "Select (l)ocal or (r)emote? [l/r]"
    read -r choice
    if [[ "$choice" =~ ^[Rr] ]]; then
        branch_list="$remote_branch_list"
    else
        branch_list="$local_branch_list"
    fi
  elif [ -n "$local_branch_list" ]; then
    branch_list="$local_branch_list"
  else
    branch_list="$remote_branch_list"
  fi

  local count
  count=$(echo "$branch_list" | grep -c .)

  if [ "$count" -eq 1 ]; then
    selected_branch=$(echo "$branch_list" | tr -d ' ')
  else
    log_tilde_box "Multiple branches found $thinking:\n$(echo "$branch_list" | awk '{print NR-1 " " $1}')"
    echo "Select branch index:"
    read -r branch_index
    selected_branch=$(echo "$branch_list" | awk -v idx="$branch_index" 'NR==idx+1 {print $1}')
  fi

  if [ -z "$selected_branch" ]; then
    echo "Selection failed $unhappy"
    return 1
  fi

  echo "Checking out $selected_branch $happy..."
  git checkout "$selected_branch" || git checkout -b "$selected_branch" "origin/$selected_branch"
}

alias checkout_branch_handler="checkout_branch_handler"
checkout_branch_handler "$1"
