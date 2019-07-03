#!/usr/bin/python
# Reverse engineering secret_phase

import sys

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


def phase_defused():
    pass


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


def secret_phase(answer):
    answer = int(answer)

    if (answer - 1) > 1000:
        return False
    
    if fun7(tree, answer) != 7:
        return False

    print("Wow!, You've defused the secret stage!")
    phase_defused()
    return True

def solve():
    for i in range(1002):
        if secret_phase(str(i)):
            return str(i)

if __name__ == "__main__":
    answer = solve()
    if answer:
        print("Bomb defused.\nAnswer: {}".format(answer))
