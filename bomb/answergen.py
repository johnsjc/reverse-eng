#!/usr/bin/python
# answer generator

from python import phase1, phase2, phase3, phase4, phase5, phase6
from python import secret_phase, phase_defused

answers = [
    phase1.solve(),
    phase2.solve(),
    phase3.solve(),
    phase4.solve(),
    phase5.solve(),
    phase6.solve(),
]

secret = secret_phase.solve()
if secret:
    answers[3] = phase_defused.answers[3]
    answers.append(secret)


print("Generating answer file...")
with open("answers", "w") as answer_file:
    for answer in answers:
        print(answer)
        answer_file.write(answer + "\n")
