# git_message() {
#     local commit="$(git commit -m $1)"
#     return 1
# }

# git_modified() {
#     local newfile=$(git status | grep -E "(new file:)" | sed 's/^.*: //')
#     local modified=$(git status | grep -E "modified" | sed 's/^.*: //')

#     echo $newfile
#     echo $modifed

#     # echo ${#newfile}
#     echo ${#modified}

#     while [ ${#modified} -gt 0 ]; do
#         read -p "Do you want to commit? " yn

#         case $yn in
#         [Yy]*)
#             read -p "Type message:" msg
#             if [ ${#msg} -gt 0 ]; then

#                 $(git commit -m "$msg")
#                 echo $modified
#                 echo $msg
#             else
#                 echo "Message should be longer than 0"
#             fi

#             break
#             ;;
#         [Nn]*) exit ;;
#         *) echo "Enter y or n" ;;
#         esac

#     done
# }

# count_files(){
#     echo "$(ls -Uba1 $1 | wc -l)"
# }

# export -f count_files
# ./bash_aliases