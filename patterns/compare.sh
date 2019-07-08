# Get the script directory so we can run the printfn helper function
DIR="$(cd "$(dirname "$0")" && pwd)"

# Uses diff to compare assembly instructions for the same function in two files.
colordiff -y <($DIR/printfn.sh $1 $3) <($DIR/printfn.sh $2 $3)

# Example:
#
# $ compare.sh x86.asm x86o.asm main
# <x86 main>:                                                   | <x86o main>:
# push   ebp                                                    <
# mov    ebp,esp                                                <
# push   0x80484c0                                                push   0x80484c0
# call   80482e0 <puts@plt>                                       call   80482e0 <puts@plt>
# add    esp,0x4                                                | pop    eax
# mov    eax,0x0                                                | xor    eax,eax
# leave                                                         <
# ret                                                             ret
#
