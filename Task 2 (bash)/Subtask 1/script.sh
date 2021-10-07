#!/bin/bash

#Arguments:
#--file - path to the file
#--workers - number of workers for parallel
#--column - name of column with links
#--folder - Folder for downlodaing pages

# Read aurguments
for arg in "$@"
do
 index=$(echo $arg | cut -f1 -d=)
 val=$(echo $arg | cut -f2 -d=)
 case $index in
  --file) file=$val;;
  --workers) workers=$val;;
  --column) column=$val;;
  --folder) folder=$val;;
  *)
 esac
done

# Check arguments
if [ -z "$file" ]
then
  echo "No filename provided"
  exit 1
fi

if [ -z "$workers" ]
then
  echo "No workers number provided"
  exit 1
fi

if [ -z "$column" ]
then
  echo "No column name provided"
  exit 1
fi

if [ -z "$folder" ]
then
  echo "No folder provided"
  exit 1
fi

# Find index of the column
column_index=$(head -1 $file | tr ';' '\n' | nl |grep -w "$column" | tr -d " " | awk -F " " '{print $1}')

# Check if the column position was found
if [ -z "$column_index" ]
then
  echo "Incorrect column name"
  exit 1
fi

# Transform links to the array
links=( $(tail -n +2 $file | cut -d ';' -f${column_index}) )

#run wget in parallel
printf '%s\n' "${links[@]}" | parallel -j $workers --progress wget {} -q -P $folder

#alternative solution
#parallel -j $workers --progress wget {} -q -P $folder ::: "${links[@]}"
