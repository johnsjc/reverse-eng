echo "<${1%%.*} $2>:"
cut -f3 $1 | awk -v pattern="$2>:" '$0 ~ pattern' RS= | awk '1;/^ret/{exit}' | sed 1d
