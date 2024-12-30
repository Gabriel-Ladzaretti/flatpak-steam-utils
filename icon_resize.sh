#!/bin/bash

set -euo pipefail

icon_src=${1:?"Error: Argument <icon_source> is required. Usage: $0 <icon_source> <icon_dest>"}
icon_dest=${2:?"Error: Argument <icon_dest> is required. Usage: $0 <icon_source> <icon_dest>"}

USER_HICOLOR_DIR="${HOME}/.local/share/icons"

if ! command -v convert &>/dev/null; then
    echo "Error: 'convert' command not found. Please install ImageMagick." >&2
    exit 1
fi

if [ ! -f "$icon_src" ]; then
    echo "Error: Source file '$icon_src' does not exist or is not a regular file." >&2
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
    convert -resize "$size" "$icon_src" "${USER_HICOLOR_DIR}/${size}/apps/${icon_dest}"
done
