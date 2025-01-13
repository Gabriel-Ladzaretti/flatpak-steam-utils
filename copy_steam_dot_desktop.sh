#!/bin/bash

FILE_LIST=${1:?"Usage: $0 <file_list> [scale_factor] (optional, default: 1)"}
SCALE_FACTOR="${2:-1}"

STEAM_DOT_DESKTOP_DIR="${HOME}/.var/app/com.valvesoftware.Steam/Desktop"
STEAM_HICOLOR_DIR="${HOME}/.var/app/com.valvesoftware.Steam/.local/share/icons"

USER_DESKTOP_DIR="${HOME}/.local/share/applications"
USER_HICOLOR_DIR="${HOME}/.local/share/icons"

# Run script

cp -r --update=none "$STEAM_HICOLOR_DIR"/* "$USER_HICOLOR_DIR"

temp_dir=$(mktemp -d)
trap 'rm -rf "${temp_dir}"' EXIT

while IFS= read -r file; do
    trimmed_file=$(echo "$file" | xargs)
    if [ -z "$trimmed_file" ]; then
        continue
    fi
    echo cp "${STEAM_DOT_DESKTOP_DIR}/$trimmed_file" "$temp_dir"
    cp "${STEAM_DOT_DESKTOP_DIR}/$trimmed_file" "$temp_dir"
done < <(
    cat "$FILE_LIST"
    echo
)

# Modify the desktop entries so that the Exec entrypoint uses the Flatpak Steam
for file in "$temp_dir"/*.desktop; do
    sed -i -E "s|^Exec=steam (.*)$|Exec=flatpak run com.valvesoftware.Steam \1 -forcedesktopscaling ${SCALE_FACTOR}|" "$file"
done

cp --update=none "$temp_dir"/*.desktop "$USER_DESKTOP_DIR"

echo "Desktop entries successfully copied from '${STEAM_DOT_DESKTOP_DIR}' to '${USER_DESKTOP_DIR}'."
echo "Icon files successfully copied from '${STEAM_HICOLOR_DIR}' to '${USER_HICOLOR_DIR}'."
