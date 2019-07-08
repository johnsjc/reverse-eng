#!/bin/bash

# Create the README.md skeleton

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIR=${PWD##*/}

cat <<EOF > README.md
### Source code

\`\`\`c
$(cat $DIR.c)
\`\`\`

---

### Intel x86 (gcc 7.4.0)

\`\`\`asm
$(diff -y <(print_fn.sh x86.asm main) <(print_fn.sh x86o.asm main))
\`\`\`

---

### Intel x64 (gcc 4.7.0)

\`\`\`asm
$(diff -y <(print_fn.sh x64.asm main) <(print_fn.sh x64o.asm main))
\`\`\`

---

### ARM (gcc 4.7.0)
\`\`\`asm
$(diff -y <(print_fn.sh arm.asm main) <(print_fn.sh armo.asm main))
\`\`\`

---

### ARM Thumb Mode (gcc 4.7.0)
\`\`\`asm
$(diff -y <(print_fn.sh arm_thumb.asm main) <(print_fn.sh arm_thumbo.asm main))
\`\`\`


### Observations
$(cat ./obs)
EOF
