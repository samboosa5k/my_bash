#!/bin/bash
# read csv file and solve any problems that may prevent postgres from reading the csv file.

input_file="${1:-index_formatted.csv}"

if [ ! -f "$input_file" ]; then
    echo "Error: File $input_file not found."
    exit 1
fi

# backup
cp "$input_file" "${input_file}.bak"

# make all letters lowercase
sed -i 's/\(.*\)/\L\1/' "$input_file"

# replace dutch month names with english
sed -i 's/oktober/october/g' "$input_file"
sed -i 's/januari/january/g' "$input_file"
sed -i 's/februari/february/g' "$input_file"
sed -i 's/maart/march/g' "$input_file"
sed -i 's/mei/may/g' "$input_file"
sed -i 's/juni/june/g' "$input_file"
sed -i 's/juli/july/g' "$input_file"
sed -i 's/augustus/august/g' "$input_file"
