# Hyprland Cheat Sheet

Source of truth: `~/.config/hypr/config/binds.lua` (regenerate/update this file when binds change).
`mainMod` = **SUPER**. `NUM_WPM = 3`, so numbered workspaces are `1`–`3`.

## Window management

| Shortcut | Action |
| --- | --- |
| `SUPER + Q` | Close window |
| `SUPER + Escape` | Kill window (`hyprctl kill`) |
| `SUPER + ALT + Space` | Toggle floating |
| `SUPER + ALT + F` | Fullscreen (mode 0) |
| `SUPER + ALT + D` | Maximize (fullscreen mode 1) |
| `SUPER + ALT + J` | Toggle split |

## Focus

| Shortcut | Action |
| --- | --- |
| `SUPER + Left/Right/Up/Down` | Move focus in direction |
| `ALT + Tab` | Window switcher (hold) |
| `SUPER + Tab` | Window switcher (hold) |
| `SUPER + SHIFT + Tab` | Window switcher (hold) |

## Move / resize windows

| Shortcut | Action |
| --- | --- |
| `SUPER + SHIFT + Up/Right/Left/Down` | Move window in direction |
| `SUPER + SHIFT + 1/2/3` | Move window to workspace 1/2/3 |
| `SUPER + CONTROL + SHIFT + 1/2/3` | Move window to workspace on same monitor (offset) |
| `SUPER + CONTROL + SHIFT + Right/Left` | Move window to next/prev workspace on current monitor |
| `SUPER + SHIFT + mouse_up / mouse_down` | Move window to previous/next monitor |
| `SUPER + CONTROL + SHIFT + mouse_up / mouse_down` | Move window to prev/next monitor |
| `SUPER + mouse:272` (LMB) | Drag window |
| `SUPER + mouse:273` (RMB) | Resize window |

## Zoom (cursor zoom)

| Shortcut | Action |
| --- | --- |
| `SUPER + Minus` | Zoom out (repeats) |
| `SUPER + Plus` | Zoom in (repeats) |
| `SUPER + keypad - / +` | Zoom out/in (repeats) |

## Launcher

| Shortcut | Action |
| --- | --- |
| `SUPER + Return` | Terminal (kitty) |
| `SUPER + E` | Launch or focus files helper |
| `SUPER + ALT + T` | Launch or focus editor helper |
| `SUPER + CONTROL + C` | Launch or focus calculator helper |
| `XF86Calculator` | Calculator |
| `SUPER + ALT + W` | Launch or focus browser helper |
| `CONTROL + SHIFT + Escape` | btop in terminal |
| `SUPER + ALT + Z` | Noctalia settings |
| `SUPER + ALT + X` | Control center |
| `SUPER + Space` | Launcher |
| `SUPER + period` | Emoji launcher |
| `ALT + Space` | Launcher |
| `SUPER + L` | Lock session |
| `SUPER + ALT + C` | Session panel |
| `SUPER + ALT + V` | Clipboard history |
| `SUPER + ALT + M` | Desktop actions menu helper |
| `SUPER + ALT + K` | Shortcut guide helper |

## Hardware controls

| Shortcut | Action |
| --- | --- |
| `XF86AudioRaiseVolume` / `LowerVolume` | Volume up/down |
| `XF86AudioMute` | Mute output |
| `XF86AudioMicMute` | Mute mic |
| `XF86AudioPlay` / `Pause` | Play/pause |
| `XF86AudioNext` / `Prev` | Next/prev track |
| `XF86MonBrightnessUp` / `Down` | Brightness up/down |

## Utilities

| Shortcut | Action |
| --- | --- |
| `SUPER + ALT + P` | Color picker (`hyprpicker -a -n`) |
| `Print` | Screenshot region |
| `SUPER + SHIFT + 4` | Screenshot region |
| `SUPER + Print` | Screenshot fullscreen |
| `SUPER + ALT + SHIFT + 3` | Screenshot fullscreen |
| `SUPER + ALT + SHIFT + W` | Wallpaper panel |
| `SUPER + ALT + A` | Notifications panel |
| `SUPER + ALT + O` | Extract region text helper |
| `SUPER + BackSpace` | Delete selection / move files to trash |

## Workspaces & monitors

| Shortcut | Action |
| --- | --- |
| `SUPER + 1/2/3` | Focus workspace 1/2/3 (absolute) |
| `SUPER + ALT + 1/2/3` | Focus monitor 1/2/3 |
| `SUPER + CONTROL + 1/2/3` | Focus workspace by offset (relative) |
| `SUPER + CONTROL + Right/Left` | Focus next/prev workspace on monitor |
| `SUPER + CONTROL + Down` | Focus next empty workspace on monitor |
| `SUPER + mouse_down / mouse_up` | Scroll through workspaces (next/prev) |
| `SUPER + CONTROL + mouse_down / mouse_up` | Same, on current monitor |
| `SUPER + ALT + S` | Toggle scratchpad workspace |
| `SUPER + ALT + SHIFT + S` | Move window to scratchpad workspace |

## Notes

- `SUPER + 1/2/3` focuses numbered workspaces; use `SUPER + ALT + 1/2/3` to focus monitors.
- Fullscreen mode 0 (`SUPER + ALT + F`) covers the whole screen; mode 1 (`SUPER + ALT + D`) maximizes within the tiled layout.
- Numbered workspace binds are generated from `NUM_WPM` in `config/variables.lua`; raise it (max 10) to get more numbered binds.
- Launch and utility binds call the local `~/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py` helper. Replace them if that helper is not installed. Handy is not started or bound by this profile.
