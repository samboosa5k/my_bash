#!/bin/bash
# Branch name template : <type>/<revision-number>_<description-of-type>
# Commit message template : [<commit_type>] <revision-number> - "custom message froim $1"

# usage: git_commit_message -t <commit_type> -m <commit_message>    

function git_commit_message(){
    local commit_message
    local commit_type
    local branch_name
    local revision_number

    branch_name=$(git branch | grep -E "\*" | cut -d ' ' -f2)
    # Get revision number from branch name after first / and before underscore
    revision_number=$(echo "$branch_name" | cut -d '/' -f2 | cut -d '_' -f1)

    # flags for options
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

    # flag arguments
    shift $((OPTIND -1))

    # If commit message is valid, commit
    git commit -m "[$commit_type] $revision_number - $commit_message" -n

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
git_commit_message "$1" "$2" "$3" "$4"
