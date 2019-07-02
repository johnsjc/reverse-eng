#!/usr/bin/python
# Reverse engineering phase 1

import sys


def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
    sys.exit(16)

  
def phase_1(answer):
    # answer is a string
    if answer != "Public speaking is very easy.":
        explode_bomb()

    print("Phase defused.")

        
def solve():
    return "Public speaking is very easy."


if __name__ == "__main__":
    phase_1(solve())
