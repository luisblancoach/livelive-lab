# LIVELIVE Lab

**Live: https://livelive.estudioblanco.org**

A creative instrument for the LIVELIVE identity (entertainment and eSports media).
The mark is a typographic reel of four columns whose frame/block boxes change height
while the letters keep their construction; they are never scaled. The Lab lets you
explore compositions, save them and share them as codes, and download PNG or MP4 for
social formats (1:1, 4:5, 9:16, 16:9).

## Usage

- **Format.** Pick one of 1:1, 4:5, 9:16 or 16:9.
- **Text.** Type in the text bar under the canvas. A space starts a new row and `_`
  leaves an empty cell. The Lab uses 4–12 columns and wraps longer rows.
- **Exploring.**
  - **Space** / Randomize: a new composition.
  - **M** / Mutate: a small change.
  - **G** / Variations: pick one, or copy its `LL1…` code.
  - **S** / Save: store the piece in Saved, with a thumbnail, name and code. A code
    pasted into Saved opens the piece again.
- **Right panel.**
  - Motion: Still, Pulse, Wave or Roll, with tempo, intensity and offset.
  - Material: frame/block patterns, and single or double line.
  - Colour: the brand palette with tints, tones and shades.
  - Layout: 1–3 lines.
- **Download as.** PNG gives a still. MP4 is H.264 at 30 fps with a duration you choose;
  "Match loop length" makes it loop cleanly. The shortcuts are **E** for PNG and **V**
  for MP4.
- **Brand book.** Click the logo to download the brand book (draft for review).

Full typographic rules (per-sign height ranges, fixed safe area, motion) are in
[`lab/README.md`](lab/README.md) (Spanish).

## Development

The Lab has no dependencies to install. It is a single HTML file with Canvas 2D.

```sh
python3 -m http.server 8777
# open http://127.0.0.1:8777/lab/index.html
```

- The instrument is `lab/index.html`.
- MP4 muxing uses `lab/vendor/mp4-muxer.js` (vendored, MIT).
- The brand book's source is `lab/brandbook/index.html`. To regenerate the PDF, run
  `./scripts/brandbook.sh`; it needs the local server and Google Chrome.

## Build and deployment

```sh
./scripts/build.sh      # allowlist copy into dist/ (aborts if any font file slips in)
npx wrangler pages deploy dist --project-name=livelive --branch=main --commit-dirty=true
```

- **Hosting:** the Cloudflare Pages project `livelive`, served at
  `livelive.estudioblanco.org`.
- **Credentials:** deploying needs a Cloudflare login (`wrangler login`). No
  credentials are stored in this repository.

## Known limitations

- **Glyphs:** the digits 2, 3, 4 and 5, K, `?` and accented letters are not yet rebuilt
  with the same stroke logic as S, A, C, G, J and Y.
- **Draft material:** the brand book is a draft for review. Its tints, tones and shades
  are a proposal.
- **Reference typeface:** the web licence for Akzidenz-Grotesk Condensed is not
  confirmed. The Lab draws its own constructed letters and does not use the typeface.
- **Browsers:**
  - Browsers may block repeated downloads started without a click. Each export
    should come from a real click or shortcut.
  - MP4 needs WebCodecs (current Chrome, Edge and Safari). Elsewhere, the Lab falls
    back to MediaRecorder: MP4 where supported, otherwise WebM.
- **Logo motion:** with the fixed safe area, the header logo moves less than the
  larger pieces do.

## License status

- **Code** (`lab/index.html`, `lab/brandbook/index.html`, `scripts/`): no open-source
  licence has been granted. All rights are reserved by the author until the licence is
  decided; the code is public for reference only.
- **Brand material:** the LIVELIVE name, logo, colour palette and brand book belong to
  their owner and are **not licensed** for reuse.
- **Third-party material:**
  - [mp4-muxer](https://github.com/Vanilagy/mp4-muxer) 5.2.1 © 2023 Vanilagy, MIT. Its
    licence is in `lab/vendor/mp4-muxer.LICENSE`.
  - [Oswald](https://fonts.google.com/specimen/Oswald) and
    [Inter](https://fonts.google.com/specimen/Inter) are SIL Open Font License 1.1. They
    are loaded from Google Fonts, not bundled; the brand book PDF embeds subsets of them.
- **Not included:** Akzidenz-Grotesk Condensed (Berthold) is a licensed typeface and
  is not part of this repository.
