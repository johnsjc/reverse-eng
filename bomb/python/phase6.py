#!/usr/bin/python
# Reverse engineering phase 6

import sys

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


def explode_bomb(): 
    return False

def phase_6(answer):
    
    # local_vars: 
    # _n34 = pointer to node 1 in linked list
    # _n18 = pointer to num array    
    # _n38 = index

    nums = [int(x) for x in answer.split()]
    
    # Check to see if the input is 6 unique numbers
    # in the range [1, 6]
    for i in range(6):
        if (nums[i] - 1) < 0 or (nums[i] - 1) > 5:
            explode_bomb()
        while (i + 1) <= 5:
             if nums[i] == nums[i + 1]:
                explode_bomb()
             i += 1
    
    # local vars:
    # _n30 = ?
    # _n3c = sorted nodes
    
    # Order the nodes according to our input.
    # e.g. an input of 1 4 5 6 2 3
    # results in [node1, node4, node5, node6, node2, node3]  
    
    sorted_nodes = []
    for i in range(6):
        node_pos = 1
        while node_pos < nums[i]:
            node_pos += 1
        # array is zero-indexed
        sorted_nodes.append(nodes[node_pos - 1])
    
    # Link up the nodes in the sorted list
    for i in range(1, 6):
        sorted_nodes[i - 1].next_node = sorted_nodes[i]

    # final check - are the nodes in descending order?
    for i in range(5):
        if sorted_nodes[i].value < sorted_nodes[i + 1].value:
            return False

    return True


def solve():
    import itertools

    for poss in itertools.permutations([1, 2, 3, 4, 5, 6]):
        answer = " ".join([str(x) for x in poss])
        if phase_6(answer):
            return answer

if __name__ == "__main__":
    answer = solve()
    if answer:
        print("Bomb defused.\n")
        print("Answer: {}".format(answer))
