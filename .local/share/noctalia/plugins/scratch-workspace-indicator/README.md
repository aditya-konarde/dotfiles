# Scratch Workspace Indicator

Displays populated and currently active Hyprland special workspaces as compact
chips in the Noctalia bar. Active scratch pills use Noctalia's tertiary palette
role so they remain visually distinct from normal active workspace pills.

## Plugin

| Field | Value |
| --- | --- |
| ID | `local/scratch-workspace-indicator` |
| Entries | Bar widget: `scratch-workspace-indicator`; service: `workspace-state` |

## Requirements

- Noctalia v5 with plugin API 3 or newer.
- Hyprland, including its `hyprctl` utility.
- Install `socat` on `PATH`.

## Usage

Enable `local/scratch-workspace-indicator` in **Settings → Plugins**, then add
**Scratch Workspace Indicator** to the bar from **Settings → Bar**.

The widget shows special workspaces in alphabetical order. Active workspaces
remain visible when empty. Inactive workspaces appear only while populated and
can be hidden with `hide_inactive`.

## Settings

| Setting | Type | Default | Description |
| --- | --- | --- | --- |
| `max_label_chars` | `int` | `0` | Maximum Unicode characters shown from each workspace name. `0` shows the full name. |
| `hide_inactive` | `bool` | `false` | Hide populated workspaces unless they are visible on a monitor. |
| `capsule_radius` | `int` | `8` | Corner radius in logical pixels. Negative values are treated as `0`. |
| `capsule_padding` | `int` | `5` | Space before and after the label along the bar axis, in logical pixels. Negative values are treated as `0`. |
| `capsule_min_width` | `int` | `35` | Minimum capsule length along the bar axis, in logical pixels. Negative values are treated as `0`. |
| `active_style` | `select` | `"fill"` | Active capsule style: `"fill"` or `"ghost"`. |
| `inactive_style` | `select` | `"fill"` | Inactive capsule style: `"fill"` or `"ghost"`. Hidden when `hide_inactive` is enabled. |

## Notes

- Active means visible on any monitor, not focused.
- Fill style uses `tertiary` colors for active workspaces and `secondary` colors
  for inactive workspaces. Ghost style uses a transparent fill with `tertiary`
  or `on_surface` text.
- On vertical bars, capsules grow vertically and display one Unicode character
  per line from top to bottom.
- The service snapshots `hyprctl -j clients` and `hyprctl -j monitors`, then
  listens to Hyprland's `.socket2.sock` through `socat`.
- If the event socket disconnects, the service waits for it to return,
  refreshes its snapshot, and reconnects. It retains the last valid state while
  `hyprctl` is unavailable and retries failed snapshots up to twice.
