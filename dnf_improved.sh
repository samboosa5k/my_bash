# dnf grouplist --hidden | grep -E "KDE\s" | sed 's/\s\s\s//g' | sed 's/\s/\\/g'

# kde_list="$(dnf grouplist --hidden | grep -E "KDE\s" | sed 's/\s\s\s//g' | sed 's/\s/\\/g')"
# kde_list_new="$(for n in $kde_list; do echo "\"$n\"" | sed 's/\\/ /g'; done)"
