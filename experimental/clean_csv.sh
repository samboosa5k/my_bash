# read csv file and replace /run/media/jasper/1TB_Share/__PHOTO_INDEX/./ with blank
#sed -i 's/\/run\/media\/jasper\/1TB_Share\/__PHOTO_INDEX\/\.\///g' index_formatted.csv

# read csv file and solve any problems that may prevent postgres from reading the csv file. Output it to a new file and rename it a backup

#sed -i 's/\"//g' index_formatted.csv

# make all lettes lowercase
sed -i 's/\(.*\)/\L\1/' index_formatted.csv

# replace oktober with october
sed -i 's/oktober/october/g' index_formatted.csv
sed -i 's/oktober/october/g' index_formatted.csv


# replace december with december

# replace january with january
sed -i 's/januari/january/g' index_formatted.csv

# replace february with february
sed -i 's/februari/february/g' index_formatted.csv

# replace march with march
sed -i 's/maart/march/g' index_formatted.csv

# replace april with april

# replace may with may
sed -i 's/mei/may/g' index_formatted.csv

# replace june with june
sed -i 's/juni/june/g' index_formatted.csv

# replace july with july
sed -i 's/juli/july/g' index_formatted.csv

# replace august with august
sed -i 's/augustus/august/g' index_formatted.csv

# replace september with september

# replace november with november
