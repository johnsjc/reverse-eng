#!/usr/bin/python
# Reverse engineering phase 4

import sys

def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
    sys.exit(16)
  
def fib(x):
    if x <= 1: return 1
    else: return fib(x - 2) + fib(x - 1)

def phase_4(answer):
    # answer is a string %d
    try:
        answer = int(answer)
        if fib(answer) != 55:
            explode_bomb()
        else:
            print("Phase defused.")
    except:
        explode_bomb()

def solve():
    for x in range(1, 12):
      if fib(x) == 55:
          return str(x)
    return None
  
phase_4(solve())
