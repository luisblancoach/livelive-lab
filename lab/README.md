# LIVELIVE Lab — v0.7 "Reels"

LIVELIVE Lab is an instrument for finding, saving and exporting pieces of the LIVELIVE
identity (an entertainment and eSports medium) in social media formats. This file
documents the typographic rules, the interface, exports and deployment. For a short
overview, see the [root README](../README.md).

**Live:** https://livelive.estudioblanco.org

## Running locally

```sh
cd livelive-lab
python3 -m http.server 8777
# open http://127.0.0.1:8777/lab/index.html
```

- The Lab is a single file, `lab/index.html`, plus the MP4 muxer in `lab/vendor/`.
- There is no build step for development and nothing to install.
- Only the interface typeface (Oswald) comes from Google Fonts. The letters of the
  mark are constructed in code and do not depend on any font.

## Concept

Each column of the mark is a **reel** of letters. Each column's window is split into
boxes: one, two or three lines. The dividing lines move and the boxes change height.
The letters are never scaled; they are rebuilt at every height. LIVE/LIVE is the
resting state.

## Typographic rules

### 1. Construction: nothing is scaled

- **Per-column measures.** Each sign's width and stroke weight are fixed for a given
  column width `u`. They are taken from Slide 2, where `u` = 178 px at 3840 px:

  | Measure | Value | In Slide 2 |
  |---|---|---|
  | Stem | 0.124 u | 22 px |
  | Arm | 0.112 u | 20 px |
  | Diagonal (perpendicular stroke) | 0.118 u | 21 px |
  | Natural height | 0.79 u | 140 px |
  | Frame line | 0.09 u | 16 px |

- **What may stretch.** Each sign has specific segments that can grow:
  - straight stems;
  - counters between arms (E, F, H, B, P, R);
  - the straight runs of curves (O, C, G, D, U, J, S);
  - diagonals (V, A, M, N, W, X, Y, K, Z, 7, /). These keep their **perpendicular
    stroke** constant, not their horizontal width.
- **S** follows the structure of Akzidenz Medium Condensed:
  - the parts are the upper arc, left side and right terminal, spine, right side and
    left terminal, and lower arc;
  - the arcs (0.28 × width) and the spine (0.85 × width) are fixed;
  - as the letter grows, all four straight runs lengthen, so the terminals grow with
    the sides;
  - the lower-left terminal rises only half of its straight run, so the lower curve
    reads as continuous, with no horizontal cut at the centre.
- **A**:
  - the apex is flat (0.36 × width);
  - the crossbar sits low, with its bottom edge at 18% of the height, and keeps its
    thickness;
  - the letter grows below the crossbar and in the counter.
- **C** has straight terminals that grow with the letter. Its aperture is 36% of the
  straight run.
- **J**:
  - it has the width of O and U (0.36 u);
  - the hook is round and full width, with a fixed depth (0.83 × width ≈ 0.30 u) and a
    flat-cut terminal;
  - only the stem grows;
  - its minimum height is 0.64 u.
- **Y**:
  - as in Akzidenz, the arms keep their size (up to 1.3 × width) and only the stem
    grows;
  - the outer edges of the arms meet the edges of the stem exactly, clipped to the Y
    silhouette;
  - the vertex and the stem share one axis at any height, with no side step.
- **V, A, M.** Their diagonals are also clipped to the silhouette of the sign, so feet
  and vertices have no steps.

### 2. Height range per sign

Each sign keeps its construction between a minimum and a maximum height. The ranges
are `RANGE` in the code, in `u` units; the default is 0.50–6 u.

| Sign | Range | Sign | Range | Sign | Range |
|---|---|---|---|---|---|
| A | 0.72–6 | S | 0.60–5 | G | 0.58–6 |
| J | 0.64–6 | C | 0.52–6 | Q | 0.56–6 |
| B | 0.62–6 | R | 0.58–6 | M, W | 0.56–6 |
| K | 0.54–6 | Y | 0.55–6 | 2, 5, 6, 9 | 0.62–6 |
| 3, 8 | 0.64–6 | ? | 0.62–3.5 | # | 0.50–6 |
| `-` `+` `.` `:` `'` | min. 0.16–0.40 | | | | |

- **Above the maximum,** the sign stays at its maximum, centred.
- **Below the minimum,** the sign cannot be built. Motion and composition therefore
  never leave a box shorter than its sign needs.

### 3. Fixed safe area

- **Size.** Every box has an empty band of **0.20 u** at the top and another at the
  bottom; a box is the white interior of a frame, or a whole block. The side margins
  are 0.08 u.
- **Always the same.** The size does not change with the sign, the height of the box or
  the moment in the animation. The sign lives only between the bands, centred.
- **Guide.** The **Safe area** button in the dock shows the bands hatched in blue.
  - A box too short for its sign would show in red, but the system never allows it.
  - The guide is for review only and is never exported.

### 4. Motion

- **Minimum box size.** Every box is at least as tall as:
  - the minimum height of its sign, plus its accent if it has one;
  - plus 2 × 0.20 u;
  - plus the frame lines.
- **Amplitude.** Each column's amplitude is computed once so that no box ever drops
  below that minimum.
  - Nothing is clipped mid-motion: no box collapses.
  - No letter appears, disappears or gets cut.
- **Motors:**
  - *Still:* no motion.
  - *Pulse:* a soft pulse every two beats.
  - *Wave:* a wave travelling across the columns.
  - *Roll:* a sweep. With multi-row texts, the next rows come in on each bar.
- **With one line** there is no divider. The boxes stay still and the letters breathe
  within their range.

**Verification:**

- **v0.6:** 104,760 frames in motion, across 1, 2 and 3 lines, Pulse, Wave and Roll, and
  three formats:
  - no letter was skipped;
  - the tightest room was 1.03× the minimum;
  - the band was always 0.20 u.
- **v0.7:** 86,400 signs in motion with S, A, J and Y, and none was skipped.

### 5. Lines and formats

- **Lines.** Choose 1, 2 or 3 lines in *Layout*.
  - Two lines is the reference lockup.
  - Three lines alternate frame / block / frame.
- **Short canvas.** If the canvas is too short for its lines, the mark gets narrower.
  The signs never get smaller.

## Using the Lab

### Header

- **Format:** 1:1, 4:5, 9:16 or 16:9.
- **Space:** an outlined **Randomize** button, next to Mutate, Variations and Save.
- **Download as** is the only filled button.

### Brand book

Clicking the **LIVELIVE logo** opens the brand book download option; it does not
download anything by itself. The option is a small panel marked "Draft for review".
The PDF downloads only when you press **Download PDF**. **Close** or `Esc` dismisses the
panel.

### Dock and panels

- **Dock:** Text, Saved (with a counter), Shortcuts and Safe area sit above the canvas.
- **Panels** float, and the canvas re-fits to the free space.

### Text

- A space starts the next row, and `_` leaves an empty cell.
- The mark uses 4 to 12 columns; longer rows wrap.

### Variations

- **Click** a card to select it and keep editing it.
- **The copy icon** copies an `LL1z.…` code that reproduces the exact piece.

### Saved

- **Thumbnails** show a name, the format, the number of lines and a short id.
- **Actions:** click a thumbnail to open it; its icons copy the code or delete the
  entry.
- **Codes:** paste a code into the field and press *Open*, or paste it anywhere in the
  Lab with ⌘V.

### Right panel

- **01 Motion:** Still, Pulse, Wave or Roll, with Tempo, Intensity and Offset.
- **02 Material:**
  - patterns: Frame / Block, Inverted, Checker, Frames and Blocks;
  - letters: Elastic or Natural;
  - lines: Single or Double, and Line weight.
- **03 Color:** Multi or Mono, Mono color, Shuffle columns and Background.
- **04 Layout:** 1, 2 or 3 lines; Fit or Fill; Scale, Position, Height and Wall.
- **05 Caption:** an optional line under the mark.

### Palette

- **Primaries:** the four brand primaries, each with a tint, a tone and a shade.
  - The tints are also available as backgrounds.
  - The tints, tones and shades are a **draft proposal awaiting client review**.
- **Interface:** the interface uses no magenta and no transparency in its controls.

## Exports

**Download as → PNG** gives a still frame at the exact size of the format:

| Format | PNG size |
|---|---|
| 1:1 | 1080 × 1080 |
| 4:5 | 1080 × 1350 |
| 9:16 | 1080 × 1920 |
| 16:9 | 1920 × 1080 |

**Download as → MP4:**

- **Output:** H.264 High, `yuv420p`, 30 fps, 1–30 s.
- **Duration:** set it with the − / + buttons or the slider. *Match loop length* sets it
  to the length of the motion loop, so the video loops cleanly.
- **Encoding:** the Lab encodes with WebCodecs and muxes with mp4-muxer 5.2.1 (MIT). This
  is faster than real time.
- **Fallbacks when the browser has no WebCodecs:**
  - it uses the browser's own MP4 recorder instead;
  - if it cannot record MP4 either, it saves WebM and shows an `ffmpeg` command to
    convert it.

**What gets exported:** always the selected variation, or the current piece if nothing
is selected.

**Verification:**

- **v0.6:** PNG and MP4 in all four formats, with 1, 2 and 3 lines. `ffprobe` reports h264
  High, `yuv420p`, 30/1, 90 frames and 3.000 s, and every file decodes without errors.
- **v0.7:** one PNG and one MP4 were also downloaded from the live HTTPS site and
  checked.

### Keyboard shortcuts

| Key | Action |
|---|---|
| `Space` | Randomize (in Variations: a Far batch) |
| `M` | Mutate (in Variations: a Near batch) |
| `G` | Variations |
| `S` | Save |
| `E` / `V` | Download PNG / MP4 |
| `P` | Pause |
| `←` `→` | Advance the reel |
| `1`–`4` | Format |
| `T` / `Esc` | Focus the text / close panels |
| `+` `−` `0` | Preview zoom (in, out, fit) |

## Brand book

- **Files:** `lab/brandbook/livelive-brand-book-DRAFT.pdf` is 8 A4 landscape pages. It is
  generated from `lab/brandbook/index.html`, and every example in it is drawn by the
  Lab's own engine.
- **Regenerate:** run `./scripts/brandbook.sh` with the local server running (Google
  Chrome is required).
- **PDF typefaces:** only Oswald and Inter, both SIL OFL, loaded from Google Fonts.
  The system font is not used, so that no proprietary font is embedded in the PDF.
- **Status:** this is a **draft awaiting client review**.
  - The brand content needs approval.
  - The tints, tones and shades are a proposal.
  - The web licence for Akzidenz-Grotesk Condensed is not confirmed.

## Build and deployment

`scripts/build.sh` copies an explicit allowlist into `dist/`:

- `index.html`;
- `vendor/` (mp4-muxer and its licence);
- the brand book PDF;
- a `_headers` file.

The script aborts if any font material shows up in `dist/`.

```sh
./scripts/build.sh
npx wrangler pages deploy dist --project-name=livelive --branch=main --commit-dirty=true
```

- **Project:** the Cloudflare Pages project `livelive`. `wrangler.jsonc` names it and
  holds no credentials.
- **Credentials:** deploying needs a Cloudflare login (`wrangler login`).
- **Domain:** https://livelive.estudioblanco.org serves v0.7.
  - DNS: CNAME `livelive` → `livelive-7i7.pages.dev`, proxied.
  - Deployments do not touch the main site or any other subdomain.

## What is in this repository

```
.gitignore
README.md                                   ← short overview
lab/index.html                              ← the instrument
lab/README.md                               ← this document
lab/vendor/mp4-muxer.js                     ← MIT
lab/vendor/mp4-muxer.LICENSE
lab/brandbook/index.html                    ← brand book source
lab/brandbook/livelive-brand-book-DRAFT.pdf ← generated draft
scripts/build.sh                            ← builds dist/ from an allowlist
scripts/brandbook.sh                        ← regenerates the PDF
wrangler.jsonc                              ← Cloudflare Pages project "livelive" (no credentials)
```

**Not included, and not distributed** (all listed in `.gitignore`):

- `*.pfb` and `lab/public/`: the Akzidenz-Grotesk Condensed `.pfb` used as a local
  visual reference. Its Adobe/Berthold licence is not confirmed.
- `lab/local-fonts/`: local comparison material derived from that font.
- `lab/verify/` and `references/`: review captures and brand reference slides.
- `dist/`: build output.
- `.wrangler/`: local Cloudflare account state.
- `.DS_Store`.

## Licensing status

- **Code:** the source is publicly visible, but **no open-source licence has been
  granted**. All rights are reserved until a licence is decided.
- **Brand assets:** the LIVELIVE name, logo, palette and brand book are **not licensed for
  reuse**.
- **Third-party material:** see "Licensing status" in the [root README](../README.md).

## Remaining work

- **Glyphs:** the digits 2–5, K, `?` and accented letters are not yet rebuilt with the
  Akzidenz-based stroke logic that S, A, C, G, J and Y already use.
- **Licence:** confirm the web licence for Akzidenz-Grotesk Condensed and the weight used
  in the reference slides.
- **Client review:** approve the brand book and the proposed tints, tones and shades.
- **Ideas:**
  - real audio as the pulse source;
  - locking parameters before Randomize;
  - dragging the lines on the canvas.

## Changelog

- **v0.7**
  - S: lower terminal lower, with a continuous curve.
  - J: full-width hook with a fixed depth; minimum 0.64 u.
  - Y: fixed arms, aligned junction, no step.
  - Diagonals clipped to the silhouette.
  - Space / Randomize moved next to Mutate.
  - The brand book uses Inter (OFL) instead of the system font.
  - Verification: continuous sweep from minimum to maximum (240 steps) without breaks;
    86,400 signs in motion with S, A, J and Y, none skipped.
  - Deployed to livelive.estudioblanco.org.
- **v0.6**
  - S and A rebuilt.
  - Diagonals with a constant perpendicular stroke.
  - C terminals that grow with the letter.
  - Per-sign height ranges, with no scaling.
  - Fixed 0.20 u safe area.
  - 1-, 2- and 3-line compositions.
  - Draft brand book from the logo.
  - Saved thumbnails with captions.
  - Outlined Space / Randomize.
  - Primaries with tints, tones and shades; no magenta or transparency in the controls.
- **v0.5**
  - Floating panels.
  - Variations with selection and codes.
  - Download as.
  - Variable safe area (replaced in v0.6).
- **v0.4:** Akzidenz comparison, elastic S/G, interface redesign, Export to.
- **v0.3:** constructed letters, stable Pulse, MP4, zoom, light UI.
- **v0.2:** light UI, text bar, pixel-snapped grid.
- **v0.1:** reels, motors, formats, saved pieces, PNG/WebM.
