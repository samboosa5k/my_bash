# dir1=$(ls /run/media/jasper/LUMIX/DCIM/100_PANA/)
#dir2_noext=$(echo $dir2 | sed -E 's/\.RW2|\.|\.\.//gm')

# dir1_noext=$(echo $dir1 | sed -E 's/\.JPG|\.|\.\.//gm')
# dir2_noext=$(echo $dir2 | sed -E 's/\.JPG|\.|\.\.//gm')

# for _pic_ in $dir1_noext; do cp /run/media/jasper/LUMIX1/DCIM/100_PANA/$_pic_.RW2 '/mnt/2TB-SSD/Pictures/Photography/2024/September/21-09-2024/' ; done

# Script

function compare_and_copy() {
    local dir_source_1
    local ext_source_1
    local dir_source_2
    local ext_source_2
    #

    local dir_source_list
    local dir_source_list_noext
    local dir_source_2_list
    local dir_cp_target

    echo "Enter the source directory 1: "
    read dir_source_1
    while [ ! -d $dir_source_1 ]; do
        echo "Directory does not exist. Please enter a valid directory: "
        read dir_source_1
    done

    echo "Enter the source extension 1: "
    read ext_source_1
    while [ -z $ext_source_1 ]; do
        echo "Extension cannot be empty. Please enter a valid extension: "
        read ext_source_1
    done

    dir_source_list=$(ls $dir_source_1 | grep $ext_source_1)
    if [ -z $dir_source_list ]; then
        echo "No files with the extension $ext_source_1 found in $dir_source_1"
        exit 1
    fi

    # strip the extension from the file names
    dir_source_list_noext=$(ls $dir_source_1 | sed -E "s/\.$ext_source_1|\.|\.\.//gm")
    if [ -z $dir_source_list_noext ]; then
        echo "No files with the extension $ext_source_1 found in $dir_source_1"
        exit 1
    fi

    echo "Enter the source directory 2: "
    read dir_source_2
    while [ ! -d $dir_source_2 ]; do
        echo "Directory does not exist. Please enter a valid directory: "
        read dir_source_2
    done

    echo "Enter the source extension 2: "
    read ext_source_2
    while [ -z $ext_source_2 ]; do
        echo "Extension cannot be empty. Please enter a valid extension: "
        read ext_source_2
    done

    echo "Enter the target directory: "
    read dir_cp_target
    while [ ! -d $dir_cp_target ]; do
        echo "Directory does not exist. Please enter a valid directory: "
        read dir_cp_target
    done

    # For each of the file strings in dir_source_list_noext, list the files in dir_source_2 that match the string
    dir_source_2_list=$(ls $dir_source_2 | grep $ext_source_2)
    for _filestring_ in $dir_source_list_noext; do
        if [ -f $dir_source_2/$_filestring_.$ext_source_2 ]; then
            file_1_path=$dir_source_1/$_filestring_.$ext_source_1
            file_2_path=$dir_source_2/$_filestring_.$ext_source_2
            echo "Copying $file_1_path to $dir_cp_target" &
            cp $dir_source_1/$_filestring_.$ext_source_1 $dir_cp_target &&
                echo "Copying $file_2_path to $dir_cp_target" &
            cp $dir_source_2/$_filestring_.$ext_source_2 $dir_cp_target
        fi
    done

    echo "Done"
    return 0
}

alias compare_and_copy=compare_and_copy
compare_and_copy
