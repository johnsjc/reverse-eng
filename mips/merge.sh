#!/bin/bash

echo $1 > nums

declare -i x=1
while [ $x -le $1 ]; do
    echo $x
    ((x++))
done | sort -R >> nums; cat nums | spim -file merge.s; rm nums
