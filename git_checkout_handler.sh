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
  local local_branch_name
  local remote_branch_name

  query=$1

  if [ -z "$query" ]; then
    echo -n "No query provided $unhappy"
    read -r query
    while [ -z "$query" ]; do
      echo -n "No query provided $angry"
      read -r query
    done
  fi

  local is_local_branch
  local is_remote_branch
  local local_branch_list
  local remote_branch_list

  if [ "$(echo "$branch_list" | wc -l)" -eq 1 ]; then
    if [ "$(echo "$branch_list" | grep -c "remote|origin" )" -eq 1 ]; then
      echo -n "Remote branch found $happy"
      is_remote_branch=1
      is_local_branch=0
      remote_branch_name="$(echo "$branch_list" | awk '{print $2}' | sed 's/remotes\/origin\///g')"
      echo -n "Remote branch name: $remote_branch_name"
    else
      echo -n "Local branch found $happy"
      is_local_branch=1
      is_remote_branch=0
      local_branch_name="$(echo "$branch_list" | awk '{print $2}')"
      echo -n "Local branch name: $local_branch_name"
    fi
  elif [ "$(echo "$branch_list" | wc -l)" -gt 1 ]; then
    echo -n "Multiple branches found $thinking"
    if [ "$(echo "$branch_list" | grep -c "remote|origin")" -eq 1 ] || [ "$(echo "$branch_list" | grep -c "remote|origin")" -gt 1 ]; then
      is_remote_branch=1
      remote_branch_list="$(echo "$branch_list" | grep -i "remote|origin")"
      echo -n "Remote branches:"
      echo -n "$remote_branch_list"
    fi

    # Check if there are local branches, erase remote branches from branch_list
    if [ "$(echo "$branch_list" | grep -c "remote|origin")" -eq 1 ] || [ "$(echo "$branch_list" | grep -c "remote|origin")" -gt 1 ]; then
      is_local_branch=1
      local_branch_list="$(echo "$branch_list" | grep -v -i "remote|origin")"
      echo -n "Local branches:"
      echo -n "$local_branch_list"
    fi
  else
    echo -n "No branches found $unhappy"
    return 1
  fi
  return 1
}

alias checkout_branch_handler="checkout_branch_handler"
checkout_branch_handler "$1"
