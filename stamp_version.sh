#!/bin/bash
# Rewrites the "Version Update" stamp in public/index.html to the current Pacific time.
cd "$(dirname "$0")"
STAMP=$(TZ=America/Los_Angeles date +"%b %-d, %Y %-I:%M %p PT")
python3 - "$STAMP" <<'PY'
import re, sys
p='public/index.html'
s=open(p).read()
s2=re.sub(r'<!--VERSION-->.*?<!--/VERSION-->', '<!--VERSION-->'+sys.argv[1]+'<!--/VERSION-->', s, flags=re.S)
assert s2!=s or sys.argv[1] in s
open(p,'w').write(s2)
print('stamped', sys.argv[1])
PY
