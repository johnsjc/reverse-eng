#!/usr/bin/python
# bomb2.py - some refactoring

import sys

def main(myFile=None):
    print(myFile)

if __name__ == '__main__':
    num_args = len(sys.argv)
    
    if len(sys.argv) == 1:
        main()
    
    elif len(sys.argv) == 2:
        try:
            with open(sys.argv[1], "r") as f:
                myFile = f.read()
                main(myFile)
        except:
            print("{}: Error opening {}. Exiting..".format(*sys.argv))
            sys.exit(8)
    else:
        print("Usage: {} <file>".format(sys.argv[0]))
        sys.exit(8)
