#!/bin/bash

set -euo pipefail

FILE_LIST=${1:?"Usage: $? <file_list>"}

STEAM_DOT_DESKTOP_DIR="${HOME}/.var/app/com.valvesoftware.Steam/Desktop"
STEAM_HICOLOR_DIR="${HOME}/.var/app/com.valvesoftware.Steam/.local/share/icons"

USER_DESKTOP_DIR="${HOME}/.local/share/applications"
USER_HICOLOR_DIR="${HOME}/.local/share/icons"

# Run script

cp -rn "$STEAM_HICOLOR_DIR"/* "$USER_HICOLOR_DIR"

temp_dir=$(mktemp -d)
trap 'rm -rf "${temp_dir}"' EXIT

while IFS= read -r file; do
    echo cp "${STEAM_DOT_DESKTOP_DIR}/$file" "$temp_dir"
    cp "${STEAM_DOT_DESKTOP_DIR}/$file" "$temp_dir"
done <"$FILE_LIST"

# Modify the desktop entries so that the Exec entrypoint uses the Flatpak Steam
for file in "$temp_dir"/*.desktop; do
    sed -i 's|^Exec=steam|Exec=flatpak run com.valvesoftware.Steam|' "$file"
done

cp -n "$temp_dir"/*.desktop "$USER_DESKTOP_DIR"

echo "Desktop entries successfully copied from '${STEAM_DOT_DESKTOP_DIR}' to '${USER_DESKTOP_DIR}'."
echo "Icon files successfully copied from '${STEAM_HICOLOR_DIR}' to '${USER_HICOLOR_DIR}'."
