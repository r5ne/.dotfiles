#!/bin/sh

# ==========================================
# 1. CONFIGURATION (Fill these in)
# ==========================================
# Set your digikam destination directory.
# Note: Use $HOME instead of ~ for safety in bash scripts.
DEST_DIR="$HOME/camera"

# Set the target extension you want to process in the current directory (no dot).
TARGET_EXT="jxl"
# ==========================================

# Check if destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    echo "Error: Destination directory '$DEST_DIR' does not exist. Aborting."
    exit 1
fi

files=(*."$TARGET_EXT")

if [ ${#files[@]} -eq 0 ]; then
    echo "No .$TARGET_EXT files found in the current directory."
    exit 0
fi

for file in "${files[@]}"; do
    # Strip the extension to get the base name (e.g., "img0" from "img0.jxl")
    basename="${file%.$TARGET_EXT}"
    
    dest_file="$DEST_DIR/$file"
    dest_sidecar="$DEST_DIR/$basename.$TARGET_EXT.xmp"
    
    echo "Processing '$file'..."

    # FAIL STATE 1: Destination edited file already exists
    if [ -e "$dest_file" ]; then
        echo "  [!] Error: '$dest_file' already exists. Aborting to prevent overwrite."
        exit 1
    fi

    # FAIL STATE 2: Destination renamed .xmp already exists
    if [ -e "$dest_sidecar" ]; then
        echo "  [!] Error: '$dest_sidecar' already exists. Aborting to prevent overwrite."
        exit 1
    fi

    # FAIL STATE 3: Find the original sidecar (e.g., img0.HEIC.xmp or img0.jpg.xmp)
    shopt -s nullglob
    # This glob looks for any file matching basename.*.xmp in the destination
    existing_sidecars=("$DEST_DIR"/"$basename".*.xmp)
    shopt -u nullglob

    if [ ${#existing_sidecars[@]} -eq 0 ]; then
        echo "  [!] Error: No original sidecar found for '$basename' in '$DEST_DIR'. Aborting."
        exit 1
    elif [ ${#existing_sidecars[@]} -gt 1 ]; then
        echo "  [!] Error: Multiple original sidecars found for '$basename'. Too ambiguous. Aborting."
        exit 1
    fi

    # We safely have exactly one original sidecar
    orig_sidecar="${existing_sidecars[0]}"

    # ==========================================
    # EXECUTE MOVE & COPY
    # ==========================================
    
    echo "  -> Moving photo to '$DEST_DIR/'"
    mv "$file" "$DEST_DIR/" || { echo "  [!] Failed to move $file. Aborting."; exit 1; }

    echo "  -> Copying sidecar '$(basename "$orig_sidecar")' to '$basename.$TARGET_EXT.xmp'"
    cp "$orig_sidecar" "$dest_sidecar" || { echo "  [!] Failed to copy sidecar. Aborting."; exit 1; }
    
    echo "  Done with '$file'."
    echo "----------------------------------------"
done

echo "All .$TARGET_EXT files processed successfully!"
