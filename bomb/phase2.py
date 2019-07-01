#!/usr/bin/python
# Reverse engineering phase 2


def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
  
def phase_2(answer):
    # answer is a string %d %d %d %d %d %d
    try:
        answer = [int(x) for x in answer.split()]

        if len(answer) < 6 or answer[0] != 1:
            explode_bomb()

        i = 1
        while i  < 6:
            if answer[i] != answer[i - 1] * (i + 1):
                explode_bomb()
            i += 1
            
        print("Phase defused.")
        
    except:
        explode_bomb()    
        
def solve():
    answer = [1]
    i = 1
    while i < 6:
        answer.append(answer[i - 1] * (i + 1))
        i += 1
    return " ".join([str(x) for x in answer])

phase_2(solve())
