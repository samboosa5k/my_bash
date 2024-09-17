#!/bin/bash
# Branch name template : <type>/<revision-number>_<description-of-type>
# Commit message template : [<commit_type>] <revision-number> - "custom message froim $1"

function git_commit_message(){
    local commit_message
    local commit_type
    local branch_name
    local revision_number

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
        echo "Enter commit type:"
        read -r commit_type
    fi

    read -r commit_message <<< "$commit_message"

    # Check if commit_message is empty, else prompt for commit_message
    if [ -z "$commit_message" ]; then
        echo "Enter commit message:"
        read -r commit_message
    fi

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
        echo "Commit failed"
    fi
   
    return 0
}

alias git_commit_message=git_commit_message
git_commit_message