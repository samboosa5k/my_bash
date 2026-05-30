#!/bin/bash
# json_index.sh
# list all images in a directory and parse output data to json file
# usage: 'json_index.sh' in a directory with images
# output: json file with image data

function getImageInfo() {
  local file
  local filename
  local path
  local size
  local width
  local height
  local aspectRatio
  local type
  local date
  local relativePath
  local infoJson

  file="$1"

  # assignment
  filename=$(basename "$file")
  path=$(realpath --relative-to="$HOME" "$file")
  width=$(identify -format "%w" "$file")
  height=$(identify -format "%h" "$file")
  aspectRatio=$(echo "scale=2; $width/$height" | bc)
  size=$(du -h "$file" | cut -f1)
  type=$(file -b --mime-type "$file")
  # Original date from file properties
  date=$(stat -c %y "$file" | cut -d' ' -f1)
  relativePath=$(realpath --relative-to="$PWD" "$file")

  # format output
  infoJson=$(jq -n \
    --arg name "$filename" \
    --arg path "$path" \
    --arg size "$size" \
    --arg width "$width" \
    --arg height "$height" \
    --arg aspect_ratio "$aspectRatio" \
    --arg type "$type" \
    --arg date "$date" \
    --arg relative_path "$relativePath" \
    '{name: $name, path: $path, size: $size, width: $width, height: $height, aspect_ratio: $aspect_ratio, type: $type, date: $date, relative_path: $relative_path}')

  echo "$infoJson"

  return 0
}

alias getImageInfo=getImageInfo

function listImages() {
  local outputjson
  local filename
  local filename_date

  # formatted date
  filename_date=$(date +"%Y-%m-%d")
  filename="_images_$filename_date.json"

  local image
  local first=true
  echo "[" >"$filename"
  for image in *.jpg *.jpeg *.png; do
    [ -e "$image" ] || continue
    # glob image to pass to function
    outputjson=$(getImageInfo "${image}")
    if [ "$first" = true ]; then
      echo "$outputjson" >>"$filename"
      first=false
    else
      echo ",$outputjson" >>"$filename"
    fi
  done
  echo "]" >>"$filename"

  return 0
}

alias listImages=listImages
