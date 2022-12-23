#!/bin/bash
# .bash_functions

git_modified () {
    echo $(git status | grep  "modified")
}

