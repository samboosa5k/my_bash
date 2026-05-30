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
    local output_file="index_formatted.csv"
    echo "filename,extension,width,height,path,size,date,year,month,day" > "$output_file"
    find . -type f \( -iname "*.jpg" -o -iname "*.png" \) | while read -r img_glob; do
        # assignment
        local imagemagickstr
        local size
        local date
        local daymonthyear
        local output

        imagemagickstr=$(identify -format "%t,%e,%w,%h,$(pwd)/%d/%f" "$img_glob" | sed 's/\s\+/%20/g')
        size=$(du -h "$img_glob" | cut -f1)
        # sed strip everything after the first space, then replace colon with comma
        date=$(identify -format "%[EXIF:DateTime]" "$img_glob" | sed 's/\s\+.*//g' | sed 's/\:/\-/g')
        daymonthyear=$(echo "$date" | sed 's/\-/\,/g')
        output="$imagemagickstr","$size","$date","$daymonthyear"
        echo "Done: $img_glob"
        echo "$output" >> "$output_file"
    done
    return 0
}

alias flat_index=flat_index
flat_index
