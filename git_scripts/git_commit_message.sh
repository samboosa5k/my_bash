#!/bin/bash
# Branch name template : <type>/<revision-number>_<description-of-type>
# Commit message template : [<commit_type>] <revision-number> - "custom message froim $1"

function git_commit_message(){
    local commit_message
    local commit_type
    local branch_name
    local revision_number
    local last_msg_file="/tmp/.last_git_commit_msg"
    local last_type_file="/tmp/.last_git_commit_type"

    branch_name=$(git branch | grep -E "\*" | cut -d ' ' -f2)
    # Get revision number from branch name after first / and before underscore
    revision_number=$(echo "$branch_name" | cut -d '/' -f2 | cut -d '_' -f1)

    # function flags for options, read and assign values
    while getopts ":m:t:" opt; do
        case $opt in
            m) commit_message="$OPTARG"
            ;;
            t) commit_type="$OPTARG"
            ;;
            \?) echo "Invalid option -$OPTARG" >&2
            ;;
        esac
    done

    # read flags and assign to local variables
    shift $((OPTIND -1))

    read -r revision_number <<< "$revision_number"
    # Check if revision_number is empty, else prompt for revision_number
    if [ -z "$revision_number" ]; then
        echo "Enter revision number:"
        read -r revision_number
    fi

    read -r commit_type <<< "$commit_type"

    # Check if commit_type is empty, else prompt for commit_type
    if [ -z "$commit_type" ]; then
        local default_type=""
        [ -f "$last_type_file" ] && default_type=$(cat "$last_type_file")
        echo "Enter commit type [default: $default_type]:"
        read -r commit_type
        [ -z "$commit_type" ] && commit_type="$default_type"
    fi

    read -r commit_message <<< "$commit_message"

    # Check if commit_message is empty, else prompt for commit_message
    if [ -z "$commit_message" ]; then
        local default_msg=""
        [ -f "$last_msg_file" ] && default_msg=$(cat "$last_msg_file")
        
        if [ -n "$default_msg" ]; then
            echo "Enter commit message (Leave empty to use: '$default_msg'):"
            read -r commit_message
            [ -z "$commit_message" ] && commit_message="$default_msg"
        else
            echo "Enter commit message:"
            read -r commit_message
        fi
    fi

    # Save details to temp files in case of failure
    echo "$commit_message" > "$last_msg_file"
    echo "$commit_type" > "$last_type_file"

    # Echo commit message template
    echo "[$commit_type] revision-$revision_number - $commit_message"

    # If commit message is valid, commit
    git commit -m "[$commit_type] $revision_number - $commit_message"

    local exit_code
    exit_code=$?
    # Check exit code using mymsg
    if [ "$exit_code" -eq 0 ]; then
        echo "Committed [$commit_type] $revision_number - $commit_message"
    else
        echo "Commit failed. Message saved for retry."
    fi

    return 0
}

alias git_commit_message=git_commit_message
git_commit_message