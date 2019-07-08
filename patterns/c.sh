# Script to compile a C program to multiple architectures
# for the purposes of looking at differences in the assembly.
# Stack canaries and PIE have been removed for learning purposes.
# GCC supported. Will add clang, etc. later

compile_gcc() {
    # Compile for x86
    gcc -o x86 -mpreferred-stack-boundary=2 -fno-stack-protector -fno-pie -no-pie $1 -m32
    gcc -o x86o -mpreferred-stack-boundary=2 -fno-stack-protector -fno-pie -no-pie $1 -m32 -O4
    
    # Copmile for x64
    gcc -o x64 -fno-stack-protector -fno-pie -no-pie $1    
    gcc -o x64o -fno-stack-protector -fno-pie -no-pie $1 -O4
}

dump_assembly() {
    objdump -M intel -D x86 > x86.asm
    objdump -M intel -D x64 > x64.asm
    objdump -M intel -D x86o > x86o.asm
    objdump -M intel -D x64o > x64o.asm
}

compile_gcc $1
dump_assembly
