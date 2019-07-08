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

#### No optimizations
\`\`\`asm
$(print_fn.sh ./x86.asm main)
\`\`\`

#### Optimizations
\`\`\`asm
$(print_fn.sh ./x86o.asm main)
\`\`\`

---

### GCC x64

#### No optimizations
\`\`\`asm
$(print_fn.sh ./x64.asm main)
\`\`\`

#### Optimizations
\`\`\`
$(print_fn.sh ./x64o.asm main)
\`\`\`

---

### Observations
EOF
