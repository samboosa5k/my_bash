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
  filename=$(basename "$File")
  path=$(realpath --relative-to="$HOME" "$File")
  width=$(identify -format "%w" "$File")
  height=$(identify -format "%h" "$File")
  aspectRatio=$(echo "scale=2; $Width/$Height" | bc)
  size=$(du -h "$File" | cut -f1)
  type=$(file -b --mime-type "$File")
  # Original date from file properties
  date=$(stat -c %y "$File" | cut -d' ' -f1)
  relativePath=$(realpath --relative-to="$PWD" "$File")

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

  return 1
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
  for image in *.jpg *.jpeg *.png; do
    # glob image to pass to function
    outputjson=$(getImageInfo "${image}")
    outputjson=$(echo "$outputjson" | sed 's/}/},/g')
    echo "$outputjson" >>"$filename"
  done

  sed -i '1s/^/[/' "$filename"
  sed -i '$ s/.$//' "$filename"
  echo "]" >>"$filename"

  return 1
}

listImages
