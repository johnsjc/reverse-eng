#!/usr/bin/python
# Reverse engineering main

import sys

answer_file = None
answers = []

def explode_bomb():
    print("\nBOOM!!!\nThe bomb has blown up.")
    sys.exit(16)

def initialize_bomb():
    # sigint handler goes here
    pass

def phase_1(answer):
    print("Phase 1")

def phase_2(answer):
    print("Phase 2")

def phase_3(answer):
    print("Phase 3")

def phase_4(answer):
    print("Phase 4")

def phase_5(answer):
    print("Phase 5")

def phase_6(answer):
    print("Phase 6")

def read_line():
    return "read_line"

def phase_defused():
    pass

def main():
    initialize_bomb()

    print("Welcome to my fiendish little bomb. You have 6 phases with")
    print("which to blow yourself up. Have a nice day!")

    phase_1(read_line())
    phase_defused()

    phase_2(read_line())
    phase_defused()

    phase_3(read_line())
    phase_defused()

    phase_4(read_line())
    phase_defused()

    phase_5(read_line())
    phase_defused()

    phase_6(read_line())
    phase_defused()

if __name__ == '__main__':
    num_args = len(sys.argv)

    if num_args == 1:
        pass

    elif num_args == 2:
        try:
            with open(sys.argv[1], "r") as f:
                answer_file = f
                answers = [line.strip() for line in f.readlines()]
        except:
            print("{}: Error: Couldn't open {}".format(*sys.argv))
            sys.exit(8)
    else:
        print("Usage: {} [<input_file>]".format(sys.argv[0]))
        sys.exit(8)

    main()
