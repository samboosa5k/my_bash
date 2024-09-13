# INSTALLED=$(dnf grouplist --ids)
# echo $INSTALLED | sed -E "s/Available Groups\:(.?).+//g" | sed -E "s/(.?).+Installed Environment Groups\://g"
# echo $INSTALLED | sed -E "s/Available Groups\:(.?).+//g" | sed -E "s/(.?).+Installed Environment Groups\://g" | grep -E "(\b\s+\(\S+[\-]\S+\))"

