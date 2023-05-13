# !/bin/bash
# .bash_aliases

echo "Aliases you can use:"
echo "    hm      --> go home
    rl      --> reload bash config
    cc      --> clear terminal
    lsf     --> list files only
    lsd     --> list directories only
    dnfi    --> list installed
    dnfs    --> search
    gli     --> list group installed
    gl      --> grouplist
    st      --> git status
    gd      --> git diff names only
    "
echo "Yeah boooiiii!!!"

alias cfg="vim ~/.bashrc"
alias rl="clear && source ~/.bashrc"
alias cc="clear"
alias st="git status"
alias gd="git diff --name-only"

alias ss="sudo -s"
alias dnfi="dnf list installed"
alias dnfs="dnf search"
alias leaves="package-cleanup --leaves"
alias orphans="package-cleanup --orphans"
alias unused="rpmconf -a"
alias cleanconfig="rpmconf -c"
alias reaper="rpmreaper"

alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

alias lsf="ls -p -a | grep -v /"
alias lsd="ls -d */"

alias home="/home/jasper"
alias hm="cd ~"
alias web="cd /home/jasper/_WEB"

alias ide="/opt/PhpStorm/bin/phpstorm.sh && exit"

# programming

# alias startweb="cd /home/jasper/_WEB/react-styuled-gsap && npm storybook && sudo systemctl start docker && \
#   cd /home/jasper/_WEB/directus && \
#   sudo docker compose up -d"

# applications

# alias webstorm="exec '/home/jasper/.local/share/JetBrains/Toolbox/apps/WebStorm/ch-0/223.8214.51/bin/webstorm.sh'"
# SCRIPTZ
alias imgidx="/home/jasper/_WEB/my_bash/json_index.sh"
# alias altidx="/home/jasper/_WEB/my_bash/alt_index.sh"

alias idxdir="find * -type d | sed -e 's/\.\/*//g' > index_folders.txt"
alias idximg="find . -type f \( -iname \*.jpg -o -iname \*.png \) | sed 's/\.\///g' > index_images.txt"

function getImageInfo() {
    # echo function

    local File=$1
    # separate declaration and assignment
    local Filename
    local Path
    local Size
    local Width
    local Height
    local AspectRatio
    local Type
    local Date
    local RelativePath
    local InfoJSON

    # format output to json
    InfoJSON=$(jq -n \
        --arg name "$Filename" \
        --arg path "$Path" \
        --arg size "$Size" \
        --arg width "$Width" \
        --arg height "$Height" \
        --arg aspect_ratio "$AspectRatio" \
        --arg type "$Type" \
        --arg date "$Date" \
        --arg relative_path "$RelativePath" \
        '{name: $name, path: $path, size: $size, width: $width, height: $height, aspect_ratio: $aspect_ratio, type: $type, date: $date, relative_path: $relative_path}')

    # return value
    echo "$InfoJSON"
    return 1
}

alias getImageInfo=getImageInfo

function readme() {
    # echo "$1"
    find . -type f \( -iname \*.jpg -o -iname \*.png \) | while read -r x; do
     basename "$x"
        # assignment
        # local filename
        # local path
        # local width
        # local height
        # local aspectratio
        # local size
        # local date
        # local relativepath
        filename=$(basename "$x")
        # path=$(realpath --relative-to="$HOME" "$x")
        # width=$(identify -format "%w" "$x")
        # height=$(identify -format "%h" "$x")
        # aspectratio=$(echo "scale=2; $Width/$Height" | bc)
        # size=$(du -h "$x" | cut -f1)
        # type=$(file -b --mime-type "$x")
        # date=$(stat -c %y "$x" | cut -d' ' -f1)
        # relativepath=$(realpath --relative-to="$PWD" "$x")
        echo "$filename" 
        # $path $width $height $aspectratio $size $type $date $relativepath
    done
return 1
}
export alias readme=$readme
