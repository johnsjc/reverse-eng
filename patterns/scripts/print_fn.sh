#!/bin/bash

# Helper script to print the instructions for a function in an objdump file.

# Output a first line like <x86 main>: 
echo "<${1%%.*} $2>:"

# only interested in the instructions
# read all lines from function_name>: until blank line
# remove all lines after ret (useless nops, garbage instructions, etc) 
# remove the first line to replace with our echo 
cut -f3 $1 \
| awk -v pattern="$2>:" '$0 ~ pattern' RS= \
| awk '1;/^ret/{exit}' \
| sed 1d 

# Example:
#
# $ ../printfn.sh x86.asm main
#
# <x86 main>:
# push   ebp
# mov    ebp,esp
# push   0x80484c0
# call   80482e0 <puts@plt>
# add    esp,0x4
# mov    eax,0x0
# leave
# ret
#
