#!/usr/bin/python
# Reverse engineering phase 5

import sys


key = "isrveawhobpnutfg"


def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
    sys.exit(16)


def phase_5(answer):
    if len(answer) != 6:
        explode_bomb()

    ctext = "".join([key[ord(c) & 0xF] for c in answer])
    if ctext != "giants":
        explode_bomb()
    
    print("Phase defused.")


def solve():
    # 96 = 0110 0000
    return "".join([chr(96 + key.find(c)) for c in "giants"])
            

if __name__ == "__main__":  
    phase_5(solve())
