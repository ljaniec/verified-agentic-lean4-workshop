#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$ROOT/lean4_software_verification_15min.tex"
OUTPUT="$ROOT/lean4_software_verification_15min.pdf"
BUILD_DIR="$(mktemp -d -t lean4-presentation.XXXXXX)"

cleanup() {
  rm -rf -- "$BUILD_DIR"
}
trap cleanup EXIT

command -v latexmk >/dev/null 2>&1 || {
  printf 'error: latexmk is required to build the presentation\n' >&2
  exit 1
}

latexmk \
  -pdf \
  -interaction=nonstopmode \
  -halt-on-error \
  -file-line-error \
  -outdir="$BUILD_DIR" \
  "$SOURCE"

cp "$BUILD_DIR/lean4_software_verification_15min.pdf" "$OUTPUT"
printf 'Built %s\n' "$OUTPUT"
