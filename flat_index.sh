#!/bin/bash
# function getImageInfo() {
#     # echo function

#     local File=$1
#     # separate declaration and assignment
#     local Filename
#     local Path
#     local Size
#     local Width
#     local Height
#     local AspectRatio
#     local Type
#     local Date
#     local RelativePath
#     local InfoJSON

#     # format output to json
#     InfoJSON=$(jq -n \
#         --arg name "$Filename" \
#         --arg path "$Path" \
#         --arg size "$Size" \
#         --arg width "$Width" \
#         --arg height "$Height" \
#         --arg aspect_ratio "$AspectRatio" \
#         --arg type "$Type" \
#         --arg date "$Date" \
#         --arg relative_path "$RelativePath" \
#         '{name: $name, path: $path, size: $size, width: $width, height: $height, aspect_ratio: $aspect_ratio, type: $type, date: $date, relative_path: $relative_path}')

#     # return value
#     echo "$InfoJSON"
#     return 1
# }

# alias getImageInfo=getImageInfo

function flat_index() {
    find . -type f \( -iname \*.jpg -o -iname \*.png \) | while read -r img_glob; do
        # assignment
        local filename
        local size
        local type
        local date
        local width
        local height
        local aspectratio
        local path
        local relativepath
        local delimited_string
        local output
        # declariton
        filename=$(basename "$img_glob")
        size=$(du -h "$img_glob" | cut -f1)
        type=$(file -b --mime-type "$img_glob")
        date=$(stat -c %y "$img_glob" | cut -d' ' -f1)
        width=$(identify -format "%w" "$img_glob")
        height=$(identify -format "%h" "$img_glob")
        aspectratio=$(echo "scale=2; $width/$height" | bc)
        path=$(realpath --relative-to="$HOME" "$img_glob")
        relativepath=$(realpath --relative-to="$PWD" "$img_glob")
        delimited_string="$filename","$size","$type","$date","$width","$height","$aspectratio","$path","$relativepath",
        output="'""$delimited_string""'"
        echo "$output" >> index_formatted.txt
    done
return 1
}

alias flat_index=flat_index
flat_index