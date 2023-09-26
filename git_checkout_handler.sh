#!/bin/bash

chicken="🐤"
kitty="🐱"
unhappy="😞"
happy="😀"
sad="😢"
thinking="🤔"
angry="😡"

function checkout_branch_handler() {
  local query
  local branch_list

  query=$1

  # List branches and print index
  branch_list=$(git branch -a | grep -i "$query" | sed 's/^\s\+//g' | sed 's/\s\+//g' | sed 's/\*//g')
  branch_list=$(echo "$branch_list" | awk '{print NR-1 " " $0}')
  if [ -z "$branch_list" ]; then
    echo "No branches found"
    return 1
  fi

  local is_local_branch
  local is_remote_branch
  local local_branch_list
  local remote_branch_list

  if [ "$(echo "$branch_list" | wc -l)" -eq "1" ]; then
    echo "One branch found $happy:"
    echo "$branch_list" | awk '{print $2}'
  elif [ "$(echo "$branch_list" | wc -l)" -gt 1 ]; then
    echo "Multiple branches found $thinking:"
    # Check if there are local branches, erase remote branches from branch_list
    if [ "$(echo "$branch_list" | grep -c "remote|origin")" -gt 0 ]; then
      is_remote_branch="1"
      remote_branch_list="$(echo "$branch_list" | grep -i "remote|origin")"
      #      echo "Remote branches:"
      echo "$remote_branch_list" | awk '{print $2}'
    fi

    if [ "$(echo "$branch_list" | grep -c "remote|origin")" -eq "0" ]; then
      is_local_branch="1"
      local_branch_list="$(echo "$branch_list" | grep -v -i "remote|origin")"
      #      echo "Local branches:"
      echo "$local_branch_list" | awk '{print $2}'
    fi
  else
    echo "No branches found $unhappy"
    return 1
  fi

  local branch_type
  # Ask user to select remote or local branch if both exist
  if [ "$(echo "$local_branch_list" | wc -l)" -gt 0  ] && [ "$(echo "$remote_branch_list" | wc -l)" -gt 0  ]; then
    echo "Select branch type:"
    echo "0 Local"
    echo "1 Remote"
    read -r branch_type
    if [ "$branch_type" -eq "0" ]; then
      branch_list="$local_branch_list"
    elif [ "$branch_type" -eq "1" ]; then
      branch_list="$remote_branch_list"
    else
      echo "Invalid branch type $unhappy"
      return 1
    fi
  fi

  local branch_index
  local branch_name
  # Display a prompt to select a local or remote branch depending on the branch list
  # If there are only remote branches, create a local branch from the remote branch
  if [ "$is_local_branch" -eq "0" ] && [ "$is_remote_branch" -eq "1" ]; then
    echo "Select branch to create:"
    echo "$branch_list"
    read -r branch_index
    branch_name=$(echo "$branch_list" | awk -v branch_index="$branch_index" 'NR==branch_index+1 {print $2}')
    git checkout -b "$branch_name" "origin/$branch_name"
    return 0
  fi
}

alias checkout_branch_handler="checkout_branch_handler"
checkout_branch_handler "$1"
