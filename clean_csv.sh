# read csv file and replace /run/media/jasper/1TB_Share/__PHOTO_INDEX/./ with blank
sed -i 's/\/run\/media\/jasper\/1TB_Share\/__PHOTO_INDEX\/\.\///g' index_formatted.csv

# read csv file and solve any problems that may prevent postgres from reading the csv file. Output it to a new file and rename it a backup

sed -i 's/\"//g' index_formatted.csv
