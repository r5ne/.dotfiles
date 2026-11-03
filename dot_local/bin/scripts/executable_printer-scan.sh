#!/bin/sh

TARGET_DIR="$HOME/tmp/photo-scans"
mkdir -p "$TARGET_DIR"

# Read DPI from first command-line argument ($1), default to 600 if empty
DPI="${1:-600}"

COUNT=1
while [ -f "$TARGET_DIR/scan_$COUNT.png" ]; do
    COUNT=$((COUNT+1))
done
FINAL_OUTPUT="$TARGET_DIR/scan_$COUNT.png"

echo "=== Scanning Raw PNG to scan_$COUNT.png at ${DPI} DPI ==="
scanimage -p -o "$FINAL_OUTPUT" --format=png --mode "24bit Color[Fast]" --resolution "$DPI" -x 210 -y 297
