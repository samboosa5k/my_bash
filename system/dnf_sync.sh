# function get_kde(){
#     local my_list="$(dnf list installed | grep kde-* | awk '{print $1}')"
#     local dnf_list="$(dnf search kde* | awk '{print $1}' | sed 's/\=//g')"
#     local new_list="$(for n in $dnf_list; do if [ -z "$(echo $my_list | grep $n)" ] ; then echo $n; fi ; done;)"
#     #new_list="$(for n in $dnf_list; do if [ -n "$(echo $my_list | grep $n)" ] ; then echo $n; fi ; done;)"

#     #echo "my list:
#     #echo $my_list
#     #echo "dnf list:\n"
#     #echo $dnf_list
#     #echo "new_list::\n"
#     #echo $new_list
#     sudo dnf install $new_list --best --allowerasing --skip-broken -y
#     return 0
#   }

# alias get_kde=get_kde
# get_kde
