#!/bin/sh
# Regenerates lab/brandbook/livelive-brand-book-DRAFT.pdf from lab/brandbook/index.html.
# Needs the local server (python3 -m http.server 8777, from the repo root) and Google Chrome.
set -eu
cd "$(dirname "$0")/.."
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
URL="${URL:-http://127.0.0.1:8777/lab/brandbook/index.html}"
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer --virtual-time-budget=15000 \
  --print-to-pdf="lab/brandbook/livelive-brand-book-DRAFT.pdf" "$URL" 2>/dev/null
ls -la lab/brandbook/livelive-brand-book-DRAFT.pdf
