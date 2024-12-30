#!/bin/bash

set -euo pipefail

STEAM_DOT_DESKTOP_DIR="${HOME}/.var/app/com.valvesoftware.Steam/Desktop"
STEAM_HICOLOR_DIR="${HOME}/.var/app/com.valvesoftware.Steam/.local/share/icons"

USER_DESKTOP_DIR="${HOME}/.local/share/applications"
USER_HICOLOR_DIR="${HOME}/.local/share/icons"

# Run script

cp -rn "$STEAM_HICOLOR_DIR"/* "$USER_HICOLOR_DIR"

temp_dir=$(mktemp -d)
trap 'rm -rf "${temp_dir}"' EXIT

file_list=(
    "Balatro.desktop"
    "Black Mesa.desktop"
    "Command & Conquer Red Alert 2 and Yuris Revenge.desktop"
    "Dorfromantik.desktop"
    "Half-Life 2.desktop"e
    "Half-Life.desktop"
)

for file in "${file_list[@]}"; do
    cp "${STEAM_DOT_DESKTOP_DIR}/$file" "$temp_dir"
done

# Modify the desktop entries
for file in "$temp_dir"/*.desktop; do
    sed -i 's|^Exec=steam|Exec=flatpak run com.valvesoftware.Steam|' "$file"
done

cp -n "$temp_dir"/*.desktop "$USER_DESKTOP_DIR"
