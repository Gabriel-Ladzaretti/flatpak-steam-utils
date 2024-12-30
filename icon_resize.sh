#!/bin/bash

set -euo pipefail

source_icon=${1:?"Error: Argument <icon_source> is required. Usage: $0 <icon_source> <output_icon_name>"}
output_icon_name=${2:?"Error: Argument <output_icon_name> is required. Usage: $0 <icon_source> <output_icon_name>"}

USER_HICOLOR_DIR="${HOME}/.local/share/icons/hicolor"

if ! command -v magick &>/dev/null; then
    echo "Error: 'magick' command not found. Please install ImageMagick." >&2
    exit 1
fi

if [ ! -f "$source_icon" ]; then
    echo "Error: Source file '$source_icon' does not exist or is not a regular file." >&2
    exit 1
fi

sizes=(
    "256x256"
    "128x128"
    "96x96"
    "64x64"
    "48x48"
    "32x32"
    "24x24"
    "16x16"
)

for size in "${sizes[@]}"; do
    echo magick "$source_icon" -resize "$size" "${USER_HICOLOR_DIR}/${size}/apps/${output_icon_name}" &&
        magick "$source_icon" -resize "$size" "${USER_HICOLOR_DIR}/${size}/apps/${output_icon_name}"
done

sudo gtk-update-icon-cache -f /usr/share/icons/hicolor/
