#!/bin/sh
# Builds the public site into dist/ from an explicit allowlist.
# Ships: index.html, vendor/ (mp4-muxer, MIT) and the brand-book PDF.
# Never ships: lab/public/*.pfb, lab/local-fonts/ (licensed font material), lab/verify/, references/, READMEs.
set -eu
cd "$(dirname "$0")/.."
rm -rf dist
mkdir -p dist/vendor
cp lab/index.html dist/index.html
cp lab/vendor/mp4-muxer.js lab/vendor/mp4-muxer.LICENSE dist/vendor/
mkdir -p dist/brandbook
cp lab/brandbook/livelive-brand-book-DRAFT.pdf dist/brandbook/
cat > dist/_headers <<'H'
/*
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin
/vendor/*
  Cache-Control: public, max-age=31536000, immutable
H
# guard: fail if anything font-like slipped in
if find dist -iname '*.pfb' -o -iname '*.woff*' -o -iname '*outlines*' | grep -q .; then echo "licensed font material in dist/ — aborting" >&2; exit 1; fi
echo "dist/ ready:"; find dist -type f | sort
