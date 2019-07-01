#!/usr/bin/python
# bomb2.py

import sys
import signal
import time

m804b664 = None

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

def read_line():
    return ""

def phase_defused():
    pass

def phase_1(answer):
    pass

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
        m804b664 = "m804b648"
        main()
    
    elif len(sys.argv) == 2:
        try:
            with open(sys.argv[1], "r") as f:
                m804b664 = f.read()
                main() 
        except:
            print("{}: Error: Couldn't open {}".format(*sys.argv))
            sys.exit(8)
    else:
        print("Usage: {} [<input_file>]".format(sys.argv[0]))
        sys.exit(8)
