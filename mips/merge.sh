#!/bin/bash
# Driver program for merge.s
# Creates a list of N numbers in the range (1, N) inclusive in a random order.
# Runs merge.s program using spim with this list of numbers as the input.
# Usage: ./merge.sh <n>

echo $1 > nums

declare -i x=1
while [ $x -le $1 ]; do
    echo $x
    ((x++))
done | sort -R >> nums; cat nums | spim -file merge.s; rm nums
