#!/usr/bin/python
# Reverse engineering phase 3

import random

valid_combinations = [
    ('q', 777),
    ('b', 214),
    ('b', 755),
    ('k', 251),
    ('o', 160),
    ('t', 458),
    ('v', 780),
    ('b', 524),
]

def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
  
def phase_3(answer):
    # answer is a string %d %c %d
    try:
        answer = answer.split()
        if len(answer) < 3:
            explode_bomb()

        a = int(answer[0])
        b = answer[1]
        c = int(answer[2])

        if a > 7 or len(b) > 1:
            explode_bomb()

        # one way of implementing a switch statement..
        if valid_combinations[a] != (b, c):
            explode_bomb()

        print("Phase defused.")
            
    except:
        explode_bomb()
        
def solve():
    index = random.randint(0, len(valid_combinations) - 1)
    return "{} {} {}".format(index, *valid_combinations[index])

phase_3(solve())
