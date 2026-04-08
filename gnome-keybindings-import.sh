#!/bin/bash
set -euo pipefail

# =============================================================================
# GNOME Keyboard Shortcuts Import Script
# Restores GNOME keyboard shortcuts from a dconf dump file.
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_FILE="$SCRIPT_DIR/gnome-keybindings.dconf"
TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

flush_section() {
    local section_path="$1"
    local section_file="$2"

    if [[ -z "$section_path" || -z "$section_file" || ! -s "$section_file" ]]; then
        return
    fi

    if grep -Eq '^[[:space:]]*(\[|[[:alnum:]-]+=)' "$section_file"; then
        echo "Loading $section_path"
        dconf load "$section_path" < "$section_file"
    fi
}

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Keybindings file not found: $INPUT_FILE"
    echo "Run gnome-keybindings-export.sh first to create a backup."
    exit 1
fi

echo "This will overwrite your current GNOME keyboard shortcuts."
read -rp "Continue? [y/N] " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 0
fi

echo "Importing GNOME keyboard shortcuts from: $INPUT_FILE"

current_path=""
current_file=""

while IFS= read -r line || [[ -n "$line" ]]; do
    case "$line" in
        '# === Window Manager Keybindings ===')
            flush_section "$current_path" "$current_file"
            current_path='/org/gnome/desktop/wm/keybindings/'
            current_file="$TEMP_DIR/wm-keybindings.dconf"
            : > "$current_file"
            ;;
        '# === Media Keys (including custom shortcuts) ===')
            flush_section "$current_path" "$current_file"
            current_path='/org/gnome/settings-daemon/plugins/media-keys/'
            current_file="$TEMP_DIR/media-keys.dconf"
            : > "$current_file"
            ;;
        '# === Mutter Keybindings ===')
            flush_section "$current_path" "$current_file"
            current_path='/org/gnome/mutter/keybindings/'
            current_file="$TEMP_DIR/mutter-keybindings.dconf"
            : > "$current_file"
            ;;
        '# === Mutter Wayland Keybindings ===')
            flush_section "$current_path" "$current_file"
            current_path='/org/gnome/mutter/wayland/keybindings/'
            current_file="$TEMP_DIR/mutter-wayland-keybindings.dconf"
            : > "$current_file"
            ;;
        '# === GNOME Shell Keybindings ===')
            flush_section "$current_path" "$current_file"
            current_path='/org/gnome/shell/keybindings/'
            current_file="$TEMP_DIR/shell-keybindings.dconf"
            : > "$current_file"
            ;;
        '#'* )
            ;;
        * )
            if [[ -n "$current_file" ]]; then
                printf '%s\n' "$line" >> "$current_file"
            fi
            ;;
    esac
done < "$INPUT_FILE"

flush_section "$current_path" "$current_file"

echo "Keyboard shortcuts imported successfully."
echo "You may need to log out and back in for all changes to take effect."
