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

  # assignment
  Filename=$(basename "$File")
  # path relative to ~/
  Path=$(realpath --relative-to="$HOME" "$File")
  # get quick dimensions
  Width=$(identify -format "%w" "$File")
  Height=$(identify -format "%h" "$File")
  AspectRatio=$(echo "scale=2; $Width/$Height" | bc)
  # filesize string with Kb and no decimal places
  Size=$(du -h "$File" | cut -f1)
  Type=$(file -b --mime-type "$File")
  # Original date from file properties
  Date=$(stat -c %y "$File" | cut -d' ' -f1)
  # Relative path
  RelativePath=$(realpath --relative-to="$PWD" "$File")

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

getImageInfo "$1"