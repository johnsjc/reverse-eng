#!/usr/bin/python
# Reverse engineered CU Binary Bomb
# With some slight modifications (Python magic)

import sys
import time
import signal

answers = []
num_answers_given = 0

def next_answer():
    for answer in answers:
        yield answer
answer_gen = next_answer()


def initialize_bomb():    
    def signal_handler(sig, _):
        print("So you think you can stop the bomb with ctrl-c, do you?")
        time.sleep(3)
        print("Well... OK. :-)")
        sys.exit(16)

    signal.signal(signal.SIGINT, signal_handler)

    
def explode_bomb():
    print("\nBOOM!!!\nThe bomb exploded.")
    sys.exit(16)


def phase_defused():
    if num_answers_given != 6:
        return

    try:
        answer = answers[3].split()
        _, secret = answer
        if secret == "austinpowers":
            print("Curses, you've found the secret phase!")
            print("But finding it and solving it are quite different...")
            secret_phase()
    except:
        explode_bomb()

    print("Congratulations! You've defused the bomb!")


def phase_1(answer):
    if answer != "Public speaking is very easy.":
        explode_bomb()


def phase_2(answer):
    try:
        answer = [int(x) for x in answer.split()]
    except:
        explode_bomb()

    if len(answer) < 6 or answer[0] != 1:
        explode_bomb()

    i = 1
    while i  < 6:
        if answer[i] != answer[i - 1] * (i + 1):
            explode_bomb()
        i += 1


def phase_3(answer):
    valid_combinations = [
    ('q', 777),
    ('b', 214),
    ('b', 755),
    ('k', 251),
    ('o', 160),
    ('t', 458),
    ('v', 780),
    ('b', 524),
    ]
    answer = answer.split()
    
    if len(answer) < 3:
        explode_bomb()

    try:
        a = int(answer[0])
        b = answer[1]
        c = int(answer[2])
    except:
        explode_bomb()

    if a > 7 or len(b) > 1:
        explode_bomb()
    
    if valid_combinations[a] != (b, c):
        explode_bomb()


def phase_4(answer):
    def fib(x):
        if x <= 1: return 1
        else: return fib(x - 2) + fib(x - 1)
    
    try: 
        answer = int(answer.split()[0])
    except:
        explode_bomb()

    if fib(answer) != 55:
        explode_bomb()


def phase_5(answer):
    key = "isrveawhobpnutfg"

    if len(answer) != 6:
        explode_bomb()

    try:
        ctext = "".join([key[ord(c) & 0xF] for c in answer])
        if ctext != "giants":
            explode_bomb()
    except:
        explode_bomb()


def phase_6(answer):
    class Node(object):
        def __init__(self, number, value, next_node):
            self.number = number
            self.value = value
            self.next_node = next_node

    nodes = [
        Node(1, 0x0fd, None),
        Node(2, 0x2d5, None),
        Node(3, 0x12d, None),
        Node(4, 0x3e5, None),
        Node(5, 0x0d4, None),
        Node(6, 0x1b0, None)
    ]

    for i in range(1, 6):
        nodes[i - 1].next_node = nodes[i]  

    try:
        nums = [int(x) for x in answer.split()]
    except:
        explode_bomb()
    
    for i in range(6):
        if (nums[i] - 1) < 0 or (nums[i] - 1) > 5:
            explode_bomb()
        while (i + 1) <= 5:
             if nums[i] == nums[i + 1]:
                explode_bomb()
             i += 1
    
    sorted_nodes = []
    for i in range(6):
        node_pos = 1
        while node_pos < nums[i]:
            node_pos += 1
        sorted_nodes.append(nodes[node_pos - 1])
    
    for i in range(1, 6):
        sorted_nodes[i - 1].next_node = sorted_nodes[i]

    for i in range(5):
        if sorted_nodes[i].value < sorted_nodes[i + 1].value:
            explode_bomb()


def secret_phase():
    class Node(object):
        def __init__(self, value, left=None, right=None):
            self.value = value
            self.left = left
            self.right = right

    tree = Node(0x24,
                Node(0x8,
                    Node(0x6,
                        Node(0x1),
                        Node(0x7)),
                    Node(0x16,
                        Node(0x14),
                        Node(0x23))),
                Node(0x32,
                    Node(0x2d,
                        Node(0x28),
                        Node(0x2f)),
                    Node(0x6b,
                        Node(0x63),
                        Node(0x3e9))))               

    def fun7(node, answer):
        if not node:
            return -1

        if answer >= node.value:
            if answer == node.value:
                return 0
            else:    
                return 2 * fun7(node.right, answer) + 1
        else:
            return 2 * fun7(node.left, answer)

    answer = None
    try:
        answer = read_line()
        answer = int(answer)
    except:
        explode_bomb()
 
    if (answer - 1) > 1000:
        explode_bomb()
    
    if fun7(tree, answer) != 7:
        explode_bomb()

    print("Wow!, You've defused the secret stage!")
    phase_defused()


def read_line():
    line = None

    try:
        line = next(answer_gen)
        global num_answers_given
        num_answers_given += 1
    except:
        while line is None or line.isspace():
            line = input().strip()

    if len(line) > 80:
        print("Error: Input line too long")
        explode_bomb()

    return line


def main():
    initialize_bomb()

    print("Welcome to my fiendish little bomb. You have 6 phases with")
    print("which to blow yourself up. Have a nice day!")

    phase_1(read_line())
    phase_defused()

    print("Phase 1 defused. How about the next one?")

    phase_2(read_line())
    phase_defused()

    print("That's number 2.  Keep going!")

    phase_3(read_line())
    phase_defused()

    print("Halfway there!")

    phase_4(read_line())
    phase_defused()

    print("So you got that one.  Try this one.")

    phase_5(read_line())
    phase_defused()

    print("Good work!  On to the next...")

    phase_6(read_line())
    phase_defused()


if __name__ == '__main__':
    num_args = len(sys.argv)

    if num_args == 1:
        pass

    elif num_args == 2:
        try:
            with open(sys.argv[1], "r") as f:
                answers = [line.strip() for line in f.readlines()]
        except:
            print("{}: Error: Couldn't open {}".format(*sys.argv))
            sys.exit(8)
    else:
        print("Usage: {} [<input_file>]".format(sys.argv[0]))
        sys.exit(8)

    main()
