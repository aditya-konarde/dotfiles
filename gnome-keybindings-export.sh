#!/bin/bash
set -euo pipefail

# =============================================================================
# GNOME Keyboard Shortcuts Export Script
# Backs up all GNOME keyboard shortcuts to a dconf dump file.
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/gnome-keybindings.dconf"

echo "Exporting GNOME keyboard shortcuts..."

# Dump all relevant keyboard shortcut dconf paths
{
    echo "# GNOME Keyboard Shortcuts Backup"
    echo "# Generated on $(date -Iseconds)"
    echo "# Hostname: $(hostname)"
    echo ""

    echo "# === Window Manager Keybindings ==="
    dconf dump /org/gnome/desktop/wm/keybindings/
    echo ""

    echo "# === Media Keys (including custom shortcuts) ==="
    dconf dump /org/gnome/settings-daemon/plugins/media-keys/
    echo ""

    echo "# === Mutter Keybindings ==="
    dconf dump /org/gnome/mutter/keybindings/
    echo ""

    echo "# === Mutter Wayland Keybindings ==="
    dconf dump /org/gnome/mutter/wayland/keybindings/
    echo ""

    echo "# === GNOME Shell Keybindings ==="
    dconf dump /org/gnome/shell/keybindings/
    echo ""

} > "$OUTPUT_FILE"

echo "Keyboard shortcuts exported to: $OUTPUT_FILE"
echo ""
echo "Custom shortcuts found:"
dconf get /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings 2>/dev/null || echo "  (none)"
