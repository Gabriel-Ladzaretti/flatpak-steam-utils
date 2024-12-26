#!/bin/bash

set -euo pipefail

STEAM_DOT_DESKTOP_DIR="${HOME}/.var/app/com.valvesoftware.Steam/.local/share/applications"
STEAM_HICOLOR_DIR="${HOME}/.var/app/com.valvesoftware.Steam/.local/share/icons"

USER_DESKTOP_DIR="${HOME}/.local/share/applications"
USER_HICOLOR_DIR="${HOME}/.local/share/icons"

# Run script

cp -rn "$STEAM_HICOLOR_DIR"/* "$USER_HICOLOR_DIR"

temp_dir=$(mktemp -d)
trap 'rm -rf "${temp_dir}"' EXIT

cp "${STEAM_DOT_DESKTOP_DIR}"/*.desktop "$temp_dir"

# Modify the desktop entries
for file in "$temp_dir"/*.desktop; do
    sed -i 's|^Exec=steam|Exec=flatpak run com.valvesoftware.Steam|' "$file"
done

cp -n "$temp_dir"/*.desktop "$USER_DESKTOP_DIR"
