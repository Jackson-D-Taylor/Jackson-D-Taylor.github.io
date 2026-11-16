#!/usr/bin/env bash
#
# convert-figures.sh — turn Jackson's source figures into web-ready assets.
#
# Reads from  source_material/Unpublished Figures/   (READ-ONLY, never written to)
# Writes to   public/figures/<paper-slug>/
#
# Stills     -> WebP, long edge capped at 1600 px, quality 82.
# Animations -> H.264 MP4 (yuv420p) + VP9 WebM, width capped at 1000 px,
#               frame rate capped at 25 fps, plus a WebP poster frame.
#
# Re-running is safe: an output is rebuilt only when it is missing or older
# than its source. Pass FORCE=1 to rebuild everything.
#
#   ./scripts/convert-figures.sh
#   FORCE=1 ./scripts/convert-figures.sh
#
# Requires ffmpeg/ffprobe and cwebp (brew install ffmpeg webp).
# Note: this Homebrew ffmpeg is built without libwebp, so stills go through
# cwebp. ffmpeg still does all the scaling for video and poster frames.

set -euo pipefail

# ---------------------------------------------------------------- settings --

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

SRC_DIR="${SRC_DIR:-$REPO_ROOT/source_material/Unpublished Figures}"
OUT_DIR="${OUT_DIR:-$REPO_ROOT/public/figures}"

STILL_MAX_EDGE=1600   # px, long edge; never upscales
STILL_QUALITY=82      # cwebp -q

ANIM_MAX_WIDTH=1000   # px
ANIM_MAX_FPS=25
X264_CRF=28           # MP4 quality (lower = better/bigger)
VP9_CRF=42            # WebM quality, tuned to land near the MP4 size
POSTER_QUALITY=82

FORCE="${FORCE:-0}"

# ------------------------------------------------------------ dependencies --

for tool in ffmpeg ffprobe cwebp; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "ERROR: '$tool' not found on PATH." >&2
    echo "       Homebrew installs it under /opt/homebrew/bin — try:" >&2
    echo "         export PATH=\"/opt/homebrew/bin:\$PATH\"" >&2
    echo "       Missing entirely? brew install ffmpeg webp" >&2
    exit 1
  fi
done

if [ ! -d "$SRC_DIR" ]; then
  echo "ERROR: source directory not found: $SRC_DIR" >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# ---------------------------------------------------------------- helpers ---

# needs_rebuild SRC OUT -> true when OUT is missing, older than SRC, or FORCE=1
needs_rebuild() {
  [ "$FORCE" = "1" ] && return 0
  [ -f "$2" ] || return 0
  [ "$1" -nt "$2" ] && return 0
  return 1
}

report() {
  printf '  %-46s %7s KB\n' "${1#"$OUT_DIR"/}" "$(( ( $(stat -f%z "$1") + 512 ) / 1024 ))"
}

# still SRC OUT
# Downscale so the long edge is at most STILL_MAX_EDGE (never upscale), then
# encode to WebP. cwebp -resize 0 0 means "leave the size alone".
still() {
  local src="$1" out="$2" dims w h rw rh
  if ! needs_rebuild "$src" "$out"; then
    printf '  %-46s (up to date)\n' "${out#"$OUT_DIR"/}"
    return
  fi
  dims="$(ffprobe -v error -select_streams v:0 \
            -show_entries stream=width,height -of csv=p=0 "$src")"
  w="${dims%%,*}"
  h="${dims##*,}"
  rw=0; rh=0
  if [ "$w" -ge "$h" ]; then
    if [ "$w" -gt "$STILL_MAX_EDGE" ]; then rw="$STILL_MAX_EDGE"; fi
  else
    if [ "$h" -gt "$STILL_MAX_EDGE" ]; then rh="$STILL_MAX_EDGE"; fi
  fi
  mkdir -p "$(dirname "$out")"
  cwebp -quiet -q "$STILL_QUALITY" -m 6 -resize "$rw" "$rh" "$src" -o "$out"
  report "$out"
}

# Shared video filter chain:
#   cap the frame rate, cap the width (never upscale), force even dimensions
#   because H.264 refuses odd ones (hyperbolic.gif is 1696x1726), then 8-bit 4:2:0.
anim_vf() {
  printf "fps='min(%s,source_fps)',scale=w='min(%s,iw)':h=-2:flags=lanczos,scale=trunc(iw/2)*2:trunc(ih/2)*2,format=yuv420p" \
    "$ANIM_MAX_FPS" "$ANIM_MAX_WIDTH"
}

# anim SRC OUT_BASE POSTER_SECONDS
# Produces OUT_BASE.mp4, OUT_BASE.webm and OUT_BASE-poster.webp.
# POSTER_SECONDS picks the poster frame — several of these animations build up
# over time, so frame 0 is not always the frame worth showing.
anim() {
  local src="$1" base="$2" poster_at="$3" vf
  vf="$(anim_vf)"
  mkdir -p "$(dirname "$base")"

  # --- H.264 MP4 -----------------------------------------------------------
  if needs_rebuild "$src" "$base.mp4"; then
    ffmpeg -y -v error -i "$src" -vf "$vf" \
      -c:v libx264 -crf "$X264_CRF" -preset slow \
      -profile:v high -level 4.0 -pix_fmt yuv420p \
      -movflags +faststart -an "$base.mp4"
    report "$base.mp4"
  else
    printf '  %-46s (up to date)\n' "${base#"$OUT_DIR"/}.mp4"
  fi

  # --- VP9 WebM ------------------------------------------------------------
  if needs_rebuild "$src" "$base.webm"; then
    ffmpeg -y -v error -i "$src" -vf "$vf" \
      -c:v libvpx-vp9 -crf "$VP9_CRF" -b:v 0 \
      -row-mt 1 -deadline good -cpu-used 3 -an "$base.webm"
    report "$base.webm"
  else
    printf '  %-46s (up to date)\n' "${base#"$OUT_DIR"/}.webm"
  fi

  # --- WebP poster ---------------------------------------------------------
  if needs_rebuild "$src" "$base-poster.webp"; then
    local frame="$TMP_DIR/poster.png"
    rm -f "$frame"
    ffmpeg -y -v error -ss "$poster_at" -i "$src" -vf "$vf" -frames:v 1 "$frame"
    cwebp -quiet -q "$POSTER_QUALITY" -m 6 "$frame" -o "$base-poster.webp"
    report "$base-poster.webp"
  else
    printf '  %-46s (up to date)\n' "${base#"$OUT_DIR"/}-poster.webp"
  fi
}

# ------------------------------------------------------------------ build ---

echo "source: $SRC_DIR"
echo "output: $OUT_DIR"
echo

# --- /figures/algorithmic-pulsar-timer/ -------------------------------------
echo "algorithmic-pulsar-timer"
APTB_OUT="$OUT_DIR/algorithmic-pulsar-timer"
still "$SRC_DIR/APTB/solution_tree_schematic.jpg"   "$APTB_OUT/solution-tree-j2109.webp"
still "$SRC_DIR/APTB/solution_tree_schematic 2.jpg" "$APTB_OUT/solution-tree-sidelobe.webp"
# APTB_logo.png carries an alpha channel, but every pixel in it is fully
# opaque, so nothing is lost by encoding it without transparency.
still "$SRC_DIR/APTB/APTB_logo.png"                 "$APTB_OUT/aptb-logo.webp"
echo

# --- /figures/exotrojans/ ----------------------------------------------------
echo "exotrojans"
TROJ_OUT="$OUT_DIR/exotrojans"
still "$SRC_DIR/Trojans/zombies_logo.jpeg" "$TROJ_OUT/zombies-logo.webp"
# 1200x1200, 1000 frames at 10 fps (100 s). Poster from halfway through, where
# the pulsar, planet and asteroid are well separated.
anim "$SRC_DIR/Trojans/T_type3.gif" "$TROJ_OUT/trojan-libration" 50
# Skipped: Trojans/periodic1.gif — same scene at lower resolution, superseded
# by T_type3.gif.
echo

# --- /figures/free-floating-objects/ -----------------------------------------
echo "free-floating-objects"
ISO_OUT="$OUT_DIR/free-floating-objects"
still "$SRC_DIR/ISO/J0614-3329_p_ratio.png"  "$ISO_OUT/impact-parameter-j0614.webp"
still "$SRC_DIR/ISO/final_analysis.png"      "$ISO_OUT/critical-impact-parameter.webp"
still "$SRC_DIR/ISO/residuals_analysis.png"  "$ISO_OUT/simulated-residuals.webp"
still "$SRC_DIR/ISO/xy_projection_MW.png"    "$ISO_OUT/milky-way-xy.webp"
still "$SRC_DIR/ISO/galactic_aitoff_all.png" "$ISO_OUT/all-sky-aitoff.webp"

# 1696x1726 (odd height — this is the one that needs the even-dimension fix),
# 82 frames at 10 fps. Poster from the point of closest approach.
anim "$SRC_DIR/ISO/hyperbolic.gif"                "$ISO_OUT/hyperbolic-flyby"        5.3
# The rotating 3D views below are busy from the first frame, so an early frame
# at a good oblique angle reads better than one shot edge-on later.
anim "$SRC_DIR/ISO/niso_MW.gif"                   "$ISO_OUT/niso-milky-way"          1.3
anim "$SRC_DIR/ISO/niso_zoomed.gif"               "$ISO_OUT/niso-zoomed"             1.3
anim "$SRC_DIR/ISO/final_video.gif"               "$ISO_OUT/critical-impact-parameter-3d"           1.3
# Screen recording of the interactive Plotly map; poster from halfway, where the
# galactic plane is tilted rather than seen edge-on.
anim "$SRC_DIR/ISO/pulsar_map_vid3_2xslower.gif"  "$ISO_OUT/pulsar-map-flythrough"   2.9
echo

# Deliberately not converted:
#   ISO/pulsar_map_3d.html                  — 76 MB of inlined Plotly, not going on the site
#   Pulsar Searching/mass_posteriors.pdf    — withheld
#   Pulsar Searching/predictive_uncertainty.pdf — withheld

echo "total: $(du -sh "$OUT_DIR" | cut -f1)"
