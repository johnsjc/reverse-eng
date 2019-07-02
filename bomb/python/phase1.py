#!/usr/bin/python
# Reverse engineering phase 1


def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
  
def phase_1(answer):
    # answer is a string
    if answer != "Public speaking is very easy.":
        explode_bomb()

    else:
        print("Phase defused.")
        
def solve():
    return "Public speaking is very easy."

phase_1(solve())
