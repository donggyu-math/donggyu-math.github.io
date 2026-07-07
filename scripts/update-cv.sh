#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

DEFAULT_SOURCE="/Users/family/Documents/workspace/cv/cv.pdf"
SOURCE="${1:-$DEFAULT_SOURCE}"
TARGET="${2:-static/files/cv.pdf}"

if [[ ! -f "$SOURCE" ]]; then
  echo "CV source not found: $SOURCE" >&2
  exit 1
fi

case "$SOURCE" in
  *.pdf|*.PDF) ;;
  *)
    echo "CV source must be a PDF file: $SOURCE" >&2
    exit 1
    ;;
esac

mkdir -p "$(dirname "$TARGET")"

if [[ -f "$TARGET" ]] && cmp -s "$SOURCE" "$TARGET"; then
  echo "CV is already up to date: $TARGET"
else
  cp "$SOURCE" "$TARGET"
  echo "Updated $TARGET"
  echo "Source: $SOURCE"
fi

source_size="$(wc -c < "$SOURCE" | tr -d ' ')"
target_size="$(wc -c < "$TARGET" | tr -d ' ')"
echo "Source size: ${source_size} bytes"
echo "Target size: ${target_size} bytes"

HUGO_BIN="${HUGO_BIN:-}"
if [[ -z "$HUGO_BIN" ]]; then
  if command -v hugo >/dev/null 2>&1; then
    HUGO_BIN="$(command -v hugo)"
  elif [[ -x "/private/tmp/hugo-pkg-expanded/Payload/hugo" ]]; then
    HUGO_BIN="/private/tmp/hugo-pkg-expanded/Payload/hugo"
  else
    HUGO_BIN=""
  fi
fi

if [[ -n "$HUGO_BIN" ]]; then
  "$HUGO_BIN" --gc --minify
else
  echo "Hugo was not found, so the local build check was skipped."
  echo "Install Hugo Extended or set HUGO_BIN=/path/to/hugo to enable it."
fi

echo
echo "Done. Review the change, then commit and push:"
echo "  git add $TARGET"
echo "  git commit -m \"Update CV\""
echo "  git push"
