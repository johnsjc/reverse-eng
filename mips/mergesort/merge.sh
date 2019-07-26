#!/bin/bash
# Driver program for mergesort.s
# Creates a temporary file containing a list of n numbers in the range (1, n) inclusive in a random order.
# The first line in the file is the quantity of numbers in the input.
# Runs merge.s program using spim with this file as the input.
# Usage: ./merge.sh <n>
#
# e.g.
# 5 (number of items to follow)
# 1 (one line per number)
# 3
# 4
# 5
# 2

echo $1 > nums

declare -i x=1
while [ $x -le $1 ]; do
    echo $x
    ((x++))
done | sort -R >> nums; cat nums | java -jar ~/bin/mars.jar mergesort.s; rm nums
