DIR="$(cd "$(dirname "$0")" && pwd)"
colordiff -y <($DIR/printfn.sh $1 $3) <($DIR/printfn.sh $2 $3)
