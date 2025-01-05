# Flatpak Steam Utilities

This repository contains utility scripts for managing Flatpak Steam `.desktop` entries for the `GNOME` desktop environment.

## Scripts

### Desktop Entry Copier

This script copies Steam desktop entries from the Flatpak installation to the user’s local desktop application directory and updates the `Exec` field to use the Flatpak Steam version.

#### Usage:
```bash
./copy-desktop-entries.sh <list_file>
```

Where the list_file contains entries to copy. For example:

```
game1.desktop
game2.desktop
...
```

### Icon Resizer
This script resizes a given icon into multiple sizes and saves it to the user's hicolor icons directory with the specified name.

Usage:
```bash
./resize-icon.sh <icon_source> <output_icon_name> 
```

For example:
```bash
./resize-icon.sh ~/path/to/icon.png steam_icon_1234.png
```

This will generate and save icons based on the `icon.png` and name them `steam_icon_1234`.
These icons will be used for any `.desktop` entry with `Icon=steam_icon_1234`.
