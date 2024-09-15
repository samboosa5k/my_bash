#!/bin/bash

# get local branches
function get_branchlist() {
    git branch | sed -E 's/(\s|\*)//gm'
}

get_branchlist
