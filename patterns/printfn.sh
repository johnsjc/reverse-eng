# Output a first line like <x86 main>: 
echo "<${1%%.*} $2>:"

 # only interested in the instructions
cut -f3 $1 \

# read all lines from function_name>: until blank line
| awk -v pattern="$2>:" '$0 ~ pattern' RS= \

# remove all lines after ret (useless nops, garbage instructions, etc)
| awk '1;/^ret/{exit}' \

# remove the first line to replace with our echo
| sed 1d 
