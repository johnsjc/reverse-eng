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
    
    print("Phase 1 defused. How about the next one?")
    phase_2(read_line())
    phase_defused()

    print("That's number 2. Keep going!")
    phase_3(read_line())
    phase_defused()

    print("Halfway there!")
    phase_4(read_line())
    phase_defused()

    print("So you got that one. Try this one.")
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
    if answer != "Public speaking is very easy.":
        explode_bomb() 


def phase_2(answer):
    try:
        numbers = [int(x) for x in answer.split()]
    except:
        explode_bomb()

    if len(numbers) < 6 or numbers[0] != 1:
        explode_bomb()

    x = 1
    while x < 6:
        if numbers[x] != numbers[x - 1] * (x + 1):
            explode_bomb()
        x += 1 


def phase_3(answer):
    try:
        answer = answer.split()
        if len(answer) < 3:
            explode_bomb()

        a = int(answer[0])
        b = answer[1]
        c = int(answer[2])
    
        if len(b) > 1:
            explode_bomb()
        if a > 7:
            explode_bomb()

        if a == 0:
            if b != 'q' and c != 777:
                explode_bomb()
        elif a == 1:
            if b != 'b' and c != 214:
                explode_bomb()
        elif a == 2:
            if b != 'b' and c != 755:
                explode_bomb()
        elif a == 3:
            if b != 'k' and c != 251:
                explode_bomb()
        elif a == 4:
            if b != 'o' and c != 160:
                explode_bomb()
        elif a == 5:
            if b != 't' and c != 458:
                explode_bomb()
        elif a == 6:
            if b != 'v' and c != 780:
                explode_bomb()
        elif a == 7:
            if b != 'b' and c != 524:
                explode_bomb()
        else:
                explode_bomb()
    except:
        explode_bomb()

def phase_4(answer):
    def fib(x):
        if x <= 1: return 1 
        else: return fib(x - 2) + fib(x - 1)

    try:
        answer = int(answer)
        if fib(answer) != 55:
            explode_bomb()
    except:
        explode_bomb()

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
