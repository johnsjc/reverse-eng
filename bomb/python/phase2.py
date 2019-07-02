#!/usr/bin/python
# Reverse engineering phase 2

import sys


def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
    sys.exit(16)

  
def phase_2(answer):
    # answer is a string %d %d %d %d %d %d
    answer = [int(x) for x in answer.split()]

    if len(answer) < 6 or answer[0] != 1:
        explode_bomb()

    i = 1
    while i  < 6:
        if answer[i] != answer[i - 1] * (i + 1):
            explode_bomb()
        i += 1
            
    print("Phase defused.")

        
def solve():
    answer = [1]
    i = 1
    while i < 6:
        answer.append(answer[i - 1] * (i + 1))
        i += 1
    return " ".join([str(x) for x in answer])


if __name__ == "__main__":
    phase_2(solve())
