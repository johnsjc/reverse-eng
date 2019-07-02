#!/usr/bin/python
# answer generator

from python import phase1, phase2, phase3, phase4, phase5 

answers = [
    phase1.solve(),
    phase2.solve(),
    phase3.solve(),
    phase4.solve(),
    phase5.solve(),
]

print("Generating answer file...")
with open("answers", "w") as answer_file:
    for answer in answers:
        print(answer)
        answer_file.write(answer + "\n")
