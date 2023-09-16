# list all images in a directory and parse output data to json file

# image data
# {
#   "name": "image name",
#   "path": "image path",
#   "size": "image size Kb",
#   "width": "image width",
#   "height": "image height",
#   "type": "image type",
#   "date": "image date",
#   "relative_path": "image relative path"
# }

# get image info
# jpg|jpeg|JPG|JPEG|png|PNG
# filename+extension, filetype, filesize, width, height, relative_path, creation_date, creation_time, metadata, image_properties

#surround with double quotes and avoid globbing
function filenameSpace() {
  local filename=$1
  # surround with double quotes
  filename="\"$filename\""
  # return value
  echo "$filename"
}

function rowSpace() {
  local row=$1
  # surround with double quotes
  row="\"$row\""
  # return value
  echo "$row"
}

function getImageInfo() {
  # echo function
#  echo "getImageInfo"

  local imageFile=$1
  # separate declaration and assignment
   local imageInfo
   local imageName
   local imagePath
   local imageSize
   local imageWidth
   local imageHeight
   local imageType
   local imageDate
   local imageRelativePath
   local imageInfoJSON

  # assignment
  # get image info if extension is lowercase
#make extension lowercase
#   imageFile=$(echo "$imageFile" | tr '[:upper:]' '[:lower:]')
   # re

  imageInfo=$(identify -verbose "$imageFile")
  # escape space
#  imageInfo=$(filenameSpace "$imageInfo")
  # parse image info
  # get image name
  imageName=$(echo "$imageInfo" | grep -oP '(?<=Image: ).*(?=\n)')
  # get image path
  imagePath=$(echo "$imageInfo" | grep -oP '(?<=Directory: ).*(?=\n)')
  # get image size
  imageSize=$(echo "$imageInfo" | grep -oP '(?<=Filesize: ).*(?=\n)')
  # get image width
  imageWidth=$(echo "$imageInfo" | grep -oP '(?<=Geometry: ).*(?=x)')
  # get image height
  imageHeight=$(echo "$imageInfo" | grep -oP '(?<=Geometry: ).*(?=\+)')
  # get image type
  imageType=$(echo "$imageInfo" | grep -oP '(?<=Mime type: ).*(?=\n)')
  # get image date
  imageDate=$(echo "$imageInfo" | grep -oP '(?<=date:create: ).*(?=\n)')
  # get image relative path
  imageRelativePath=$(echo "$imageInfo" | grep -oP '(?<=relative path: ).*(?=\n)')

  # format output
  imageInfoJSON="{\"name\": \"$imageName\", \"path\": \"$imagePath\", \"size\": \"$imageSize\", \"width\": \"$imageWidth\", \"height\": \"$imageHeight\", \"type\": \"$imageType\", \"date\": \"$imageDate\", \"relative_path\": \"$imageRelativePath\"}"
  # return value
  echo "$imageInfoJSON"
}

function listAllImages() {
  local images
  # list all images ending with jpg, jpeg, png. delimiting with new line
  images=$(find . -type f -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -printf '%f\n')
  # each item in new line
  images=$(echo "$images" | tr '\n' ' ')

  # filter results which dont end with image extension

  # return value
  echo "$images"
}

function mapArray() {
  array=$1
  callback=$2

  # loop through array
  for i in "${array[@]}"; do
    # call callback
   echo "$i"
  done
}

# compose a function and pass output of listAllImages to mapArray, using callback getImageInfo
function listAllImagesInfo() {
  local images
  images=$(listAllImages)
  # re
  # treat

   echo "$images"
  # map array
  local imageInfo
  imageInfo=$(mapArray "$images" getImageInfo)
}

alias imgidx="listAllImagesInfo"