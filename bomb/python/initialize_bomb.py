#!/usr/bin/python
# Reverse engineering initialize_bomb
# Press Ctrl-C during execution

import signal
import time
import sys

def signal_handler(sig, _):
    print("So you think you can stop the bomb with ctrl-c, do you?")
    time.sleep(3)
    # Signal interrupt breaks sleep so just print it in one line.
    print("Well... OK. :-)")
    sys.exit(16)

def initialize_bomb():
    signal.signal(signal.SIGINT, signal_handler)

initialize_bomb()
time.sleep(10)
