#!/bin/bash

#Arguments:
#--input - path to the file
#--train_ratio - percentage of objects in train sample (float)
#--y_column - name of the column, where objects class labels are located
#--train_file - path to the file with train data
#--test_file - path to the file with test data

# Read aurguments
for arg in "$@"
do
 index=$(echo $arg | cut -f1 -d=)
 val=$(echo $arg | cut -f2 -d=)
 case $index in
  --input) file=$val;;
  --train_ratio) train_ratio=$val;;
  --train_file) train_file=$val;;
  --test_file) test_file=$val;;
  # deprecated
  --y_column) column=$val;;
  *)
 esac
done

#Check arguments
if [ -z "$file" ]
then
  echo "No path to the file provided"
  exit 1
fi

if [ -z "$train_ratio" ]
then
  echo "No percentage provided"
  exit 1
fi

if [ -z "$train_file" ]
then
  echo "No path to the train file provided"
  exit 1
fi

if [ -z "$test_file" ]
then
  echo "No path to the test file provided"
  exit 1
fi

if [ -z "$column" ]
then
  echo "No column name provided"
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

#Number of records (except header row)
records_count=$(($(< $file wc -l)-1))

#Number of records for train file
train_records_count=$(echo "$records_count * $train_ratio/1" | bc)

#For train file we take first rows but remove header row
head -$((train_records_count+1)) $file | tail -$train_records_count > $train_file
#For test file we rake remaining columns
tail -$((records_count-train_records_count)) $file > $test_file
