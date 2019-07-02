#!/usr/bin/python
# Reverse engineering read_line

import sys

answer_file = None
answers = [
    "banana",
    "strawberry",
    "apple",
]

def explode_bomb():
    print("\nBOOM!!!\nThe bomb has blown up.")
    sys.exit(16)

def read_line():
    line = None
    
    try:
        line = answers.pop(0)
    except:
        while line is None or line.isspace():
            line = input().strip()

    if len(line) > 80:
        print("Error: Input line too long")
        explode_bomb()

    if not line:
        if answer_file is None:
            print("Some error ocurred.")
            explode_bomb()
            
        if "GRADE_BOMB" in os.environ:
            sys.exit(0)

    return line


for i in range(5):
    print(read_line())
