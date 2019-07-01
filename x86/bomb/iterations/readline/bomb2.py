#!/usr/bin/python


import sys
import signal
import time
import os

answer_file = None
answers = []

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

def initialize_bomb():
    
    def signal_handler(sig, _):
        sys.stdout.write("So you think you can stop the bomb with ctrl-c, do you?\n")
        time.sleep(3)
        sys.stdout.write("Well... ")
        time.sleep(1)
        sys.stdout.write("OK. :-)\n")
        sys.exit(16)

    signal.signal(signal.SIGINT, signal_handler)


def blank_line(line):
    return line.isspace()


def skip():    
    try:
        line = answers.pop(0)
    except:
        line = None
        while line is None or line.isspace():
            line = raw_input().strip()
    return line


def explode_bomb():
    print("\nBOOM!!\nThe bomb has blown up.")
    sys.exit(0)


def read_line():
    line = skip()

    if line:        
        if len(line) >= 80:
            print("Error: Input line too long")
            explode_bomb()
        return line
 
    else:
        if answer_file is None:
            print("Some error occurred.")
            explode_bomb()
    
        if "GRADE_BOMB" in os.environ:
            sys.exit(0)


def phase_defused():
    pass

def phase_1(answer):
    print(answer)
    sys.exit(0)

def phase_2(answer):
    pass

def phase_3(answer):
    pass

def phase_4(answer):
    pass

def phase_5(answer):
    pass

def phase_6(answer):
    pass
    

if __name__ == '__main__':
    num_args = len(sys.argv)
    
    if len(sys.argv) == 1:
        pass
    
    elif len(sys.argv) == 2:
        try:
            with open(sys.argv[1], "r") as answer_file:
                answers = [line.strip() for line in answer_file.readlines()]
        except:
            print("{}: Error: Couldn't open {}".format(*sys.argv))
            sys.exit(8)
    
    else:
        print("Usage: {} [<input_file>]".format(sys.argv[0]))
        sys.exit(8)

    main()
