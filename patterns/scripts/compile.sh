#!/bin/bash

# Script to compile a C program to multiple architectures
# for the purposes of looking at differences in the assembly.
# Stack canaries and PIE have been removed for learning purposes.
# GCC supported. Will add clang, etc. later
# Targets: x86, x64, ARM, ARM64, MIPS

compile_intel() {
    # Compile for x86
    gcc -o x86 -D_FORTIFY_SOURCE=0 -mpreferred-stack-boundary=2 -fno-stack-protector -fno-pie -no-pie $1 -m32
    gcc -o x86o -D_FORTIFY_SOURCE=0 -mpreferred-stack-boundary=2 -fno-stack-protector -fno-pie -no-pie $1 -m32 -O4
    
    # Compile for x64
    gcc -o x64 -D_FORTIFY_SOURCE=0 -fno-stack-protector -fno-pie -no-pie $1    
    gcc -o x64o -D_FORTIFY_SOURCE=0 -fno-stack-protector -fno-pie -no-pie $1 -O4
}

compile_arm() {
    # Compile ARM mode
    arm-linux-gnueabi-gcc $1 -o arm
    arm-linux-gnueabi-gcc $1 -o armo -O4

    # Compile Thumb mode
    arm-linux-gnueabi-gcc $1 -o arm_thumb -mthumb
    arm-linux-gnueabi-gcc $1 -o arm_thumbo -mthumb -O4
}

dump_assembly() {
    # Dump Intel
    objdump -M intel -D x86 > x86.asm
    objdump -M intel -D x64 > x64.asm
    
    objdump -M intel -D x86o > x86o.asm
    objdump -M intel -D x64o > x64o.asm

    # Dump ARM
    arm-linux-gnueabi-objdump -D arm > arm.asm
    arm-linux-gnueabi-objdump -D armo > armo.asm
    
    arm-linux-gnueabi-objdump -D arm_thumb > arm_thumb.asm
    arm-linux-gnueabi-objdump -D arm_thumbo > arm_thumbo.asm
}

compile_intel $1
compile_arm $1
dump_assembly
