#!/bin/bash

function cloneme() {
    cd /home/jasper/_WEB/ &&
        git clone https://github.com/roc-lang/basic-cli.git
    return 0
}

alias cloneme=cloneme
