echo "<${1%%.*} $2>:" # <x86 main>:

cut -f3 $1 \ # only interested in the instructions
| awk -v pattern="$2>:" '$0 ~ pattern' RS= \ # read all lines from function_name>: until blank line
| awk '1;/^ret/{exit}' \ # remove all lines after ret (useless nops, garbage instructions, etc)
| sed 1d # remove the first line to replace with our echo
