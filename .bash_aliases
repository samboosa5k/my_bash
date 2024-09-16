#!/bin/bash
# .bash_aliases

export alias CFG_DIR="/Users/Jasper/Sites/my_bash_mac"
alias ss="sudo -s"

echo "Loading main aliases from $CFG_DIR/.bash_aliases"

# config and basic
alias cfg='vim $CFG_DIR/.bashrc'
alias rl='clear && source $CFG_DIR/.bashrc'
alias cc="clear"
alias hm="cd ~"
alias loopy='$CFG_DIR/loop_folder_action.sh'

echo 'main aliases loaded'
# de
export alias home="/Users/Jasper"
alias dev="cd $home/Sites/publishing/development"
alias cms="cd $home/Sites/publishing/development/cms"
alias web="cd $home/Sites/publishing/development/cms/web"
alias admin="cd $home/Sites/publishing/development/cms/admin"
alias web2="cd $home/Sites/publishing/development/web"

alias trans="$home/Sites/publishing/development/script/watcher i18n-cms"

# nav
alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"
alias bkdir='$CFG_DIR/quick_alias.sh'

echo 'git aliases loaded'

# git
alias bn='$CFG_DIR/git_branch_new.sh'
alias bb='$CFG_DIR/git_branch_find.sh'
alias bc='$CFG_DIR/git_change_utils.sh'
alias gbf='$CFG_DIR/git_branch_find.sh'
alias gbn='$CFG_DIR/git_branch_new.sh'
alias gg='$CFG_DIR/git_change_utils.sh'
alias gc='$CFG_DIR/git_commit_message.sh'
alias gb="git branch"
alias gd="git diff --name-only"
alias gbr="git branch -r"
alias rr="git reset --hard HEAD~1"
alias gr="git reset --hard HEAD~1"
alias gpo="git pull origin release/kraken --rebase -f"
alias grb="git pull origin release/kraken --autostash --rebase -f"
alias st="git status"
# alias gcurr="git branch --show-current"


alias gaa="git add ."
alias pullall="git submodule foreach --recursive git pull"
alias checkoutall="git submodule foreach --recursive git checkout"
alias branches="git submodule foreach --recursive git branch | grep -E '\*' | sed 's/\* //'"
alias changes="git submodule foreach --recursive git status --porcelain"
alias restoreall="git submodule foreach --recursive git restore ."
alias resetall="git submodule foreach --recursive git reset --hard HEAD~1"
alias fetchall="git submodule foreach --recursive git fetch -a -p"
alias gpforce="git push --force"
#alias gpf="git add . && git commit -m -read"

echo 'docker aliases loaded'
alias duck="docker-compose"
alias duckps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | awk '{print $1 $2 $3}'"
alias ducklog="docker-compose logs --no-log-prefix --since 15m -f"

echo 'docker maintenance aliases loaded'
alias rs="docker-compose ps | grep exited | awk '{print $1}' | xargs docker-compose restart"
alias restartexited="duck ps | grep exited | awk '{print $1}' | xargs docker-compose up -d"
alias heal="docker ps -f health=unhealthy --format 'table {{.Names}}' | grep -E '[a-z]' | xargs docker-compose restart"
# alias heal="duckps | grep unhealthy | for n in $(awk '{print $1}'); do docker-compose restart "$n"; done"
alias kk="docker-compose kill && docker-compose down && docker-compose up -d"
alias seed_local="~/bash/seed_local.sh"

alias dup="docker-compose up -d"
alias down="docker-compose down"

alias gogo='gb | grep 4209 | awk {print } | xargs git checkout'

echo "Aliases loaded"