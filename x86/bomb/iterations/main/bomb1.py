#!/usr/bin/python
# bomb1.py reversing the main function

import sys

def main20():
    if len(sys.argv) == 2:
        # exactly 1 argument
        try:
            with open(sys.argv[1], "r") as f:
                # move return of fopen into memory at 0x804bb64
                # the same address as before with no arguments..
                myFile = f.read()
                print(myFile)
                main80()
                
        except:
            # test eax,eax
            # jne main+80
            # if the file is null, then the jump is not taken
            print("{}: {} file not found. Exiting..".format(sys.argv[0], sys.argv[1]))
            sys.exit(8)
    else:
        main60()
            

def main60():
   print("Usage: {} <file>".format(sys.argv[0]))
   sys.exit(8) 

def main80():
   pass
   
def main():
    if len(sys.argv) == 1:
        # no arguments

        # move something in memory
        # 0x804b648 to 0x804b664
         

        # Jump unconditionally to main+80
        main80()
    
    else:
        main20()
         

if __name__ == '__main__':
    main()
