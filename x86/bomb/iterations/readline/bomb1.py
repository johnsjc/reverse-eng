#!/usr/bin/python
# bomb2.py

import sys
import signal
import time
import os

# 0x804bb64 FILE
input_file = None

# 0x804b480
lines_read = 1

# 0x804b680
lines = [None] * 6


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
    line = None
    while True:
        if input_file:
            input_lines = "".join(input_file).strip().split("\n")
            line = input_lines[lines_read]           
        else:
            line = raw_input().strip()
        
        if line and not blank_line(line):
            break
    
    lines[lines_read] = line
    return line    

def explode_bomb():
    sys.stdout.write("BOOM!")
    sys.exit(0)

def read_line3b():
    line = skip()
    if not line:
        read_line_63()
    read_line4e()

def read_line4e():
    sys.stdout.write("some message here")
    explode_bomb()

def read_line63():
    global lines_read
    line = lines[lines_read]
    if len(line) >= 80:
        sys.stdout.write("Input is too long.")
        explode_bomb()
    
    lines_read += 1
    return line

def read_line():
    line = skip()
    if line:        
        return read_line63()
    
    if not input_file:
        return read_line4e()
    
    if "GRADE_BOMB" not in os.environ:
        return read_line3b()
    else:
        sys.exit(0)

    return line

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
        main()
    
    elif len(sys.argv) == 2:
        try:
            with open(sys.argv[1], "r") as f:
                input_file = f.read()
        except:
            print("{}: Error: Couldn't open {}".format(*sys.argv))
            sys.exit(8)
    else:
        print("Usage: {} [<input_file>]".format(sys.argv[0]))
        sys.exit(8)

    main()
