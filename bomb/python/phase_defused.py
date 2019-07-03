#!/usr/bin/python
# Reverse engineering phase_defused

answers = [
    "banana",
    "strawberry",
    "apple",
    "9 austinpowers",
    "orange",
    "grape",   
]

def secret_phase():
    pass

def phase_defused():
    if len(answers) != 6:
        return
    
    try:
        answer = answers[3].split()
        _, secret = answer
        if secret == "austinpowers":
            print("Curses, you've found the secret phase!")
            print("But finding it and solving it are quite different...")
            secret_phase()
    except:
        pass

    print("Congratulations! You've defused the bomb!")

if __name__ == "__main__":
    phase_defused()
