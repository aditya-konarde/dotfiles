# Hyprland Cheat Sheet

Source of truth: `~/.config/hypr/config/binds.lua` (regenerate/update this file when binds change).
`mainMod` = **SUPER**. `NUM_WPM = 3`, so numbered workspaces are `1`–`3`.

## Window management

| Shortcut | Action |
| --- | --- |
| `SUPER + Q` | Close window |
| `SUPER + Escape` | Kill window (`hyprctl kill`) |
| `SUPER + ALT + Space` | Toggle floating |
| `SUPER + F` | Fullscreen (mode 0) |
| `SUPER + D` | Maximize (fullscreen mode 1) |
| `SUPER + J` | Toggle split |

## Focus

| Shortcut | Action |
| --- | --- |
| `SUPER + Left/Right/Up/Down` | Move focus in direction |
| `ALT + Tab` | Cycle to next window |
| `SUPER + Tab` | Window switcher (noctalia) |

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
| `SUPER + E` | File manager (dolphin) |
| `SUPER + T` | Editor (gnome-text-editor) |
| `SUPER + C` (or `XF86Calculator`) | Calculator |
| `SUPER + W` | Browser (brave-origin) |
| `CONTROL + SHIFT + Escape` | btop in terminal |
| `SUPER + Z` | Noctalia settings |
| `SUPER + X` | Control center |
| `SUPER + Space` | Launcher |
| `SUPER + period` | Emoji launcher |
| `SUPER + L` | Lock session |
| `SUPER + ALT + C` | Session panel |

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
| `CONTROL + ALT + Space` | Handy speech-to-text toggle |
| `CONTROL + SHIFT + Space` | Handy post-process toggle |
| `CONTROL + F13` | Handy toggle (G502 X sniper button) |
| `SUPER + P` | Color picker (`hyprpicker -a -n`) |
| `Print` | Screenshot region |
| `SUPER + Print` | Screenshot fullscreen |
| `SUPER + SHIFT + W` | Wallpaper panel |
| `SUPER + V` | Clipboard history |
| `SUPER + A` | Notifications panel |

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
| `SUPER + S` | Toggle scratchpad workspace |
| `SUPER + SHIFT + S` | Move window to scratchpad workspace |

## Notes

- `SUPER + 1/2/3` focuses numbered workspaces; use `SUPER + ALT + 1/2/3` to focus monitors.
- Fullscreen mode 0 (`SUPER + F`) covers the whole screen; mode 1 (`SUPER + D`) maximizes within the tiled layout.
- Numbered workspace binds are generated from `NUM_WPM` in `config/variables.lua`; raise it (max 10) to get more numbered binds.
