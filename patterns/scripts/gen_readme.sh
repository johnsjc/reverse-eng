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

### GCC x86

\`\`\`asm
$(diff -y <(print_fn.sh x86.asm main) <(print_fn.sh x86o.asm main))
\`\`\`

---

### GCC x64

\`\`\`asm
$(diff -y <(print_fn.sh x64.asm main) <(print_fn.sh x64o.asm main))
\`\`\`

---

### GCC ARM
\`\`\`asm
$(diff -y <(print_fn.sh arm.asm main) <(print_fn.sh arm_thumb.asm main))
\`\`\`

---

### Observations
EOF
