# Dotfiles

Public, curated settings for CachyOS/Linux with Hyprland and Noctalia, plus the
older macOS setup. This is a settings snapshot, not a copy of a home directory.
Credentials, accounts, histories, private hosts, and application state stay local.

## Current Linux desktop

The September 2026 snapshot includes:

- Lua Hyprland configuration: three numbered workspaces, window movement with
  `Super+Shift+1–3`, a named scratch workspace, adaptive pointer acceleration,
  opaque windows, disabled blur, VRR, and a 4K/240 Hz monitor profile.
- Noctalia bar and Control Center layout, bold workspace labels, startup DND,
  screenshot annotation with Satty, and wallpaper-generated terminal themes.
- Local Noctalia plugins for a distinct scratch-workspace indicator and audio
  output cycling from Control Center Home. Public plugin IDs use `local/`.
- Handy transcription shortcuts and an AppImage launcher; the microphone shortcut
  is `Ctrl+Alt+Space`. The launcher looks in `~/Applications` for Handy AppImages.
- Kitty split layouts and mouse/link controls, Alacritty, Zellij, Starship,
  Fish/Zsh, btop, MangoHud, and a Wayland ChatGPT launcher override.
- mpv Vulkan playback with ArtCNN/CfL shaders and an optional FSRCNNX comparison.

See [Hyprland keybindings](.config/hypr/KEYBINDINGS.md). The config was checked
with Hyprland 0.56.2 (Lua `hl` API) and Noctalia 5.1.0 / plugin API 3. Older
Hyprland builds that only support `hyprland.conf` cannot use this Lua profile.

## Install on Linux

For agent-assisted setup, follow [AGENTS.md](AGENTS.md). For example, ask your
agent: "Set up this repository on this Linux machine, including required packages
and desktop-session verification." The workflow requires checking dependencies,
following up on packages that need your action, configuring the session, and
reporting any pending login checks. The shell installer itself only copies files.

Install dependencies separately. The desktop uses Hyprland, Noctalia, UWSM,
Kitty, Dolphin, Brave Origin, GNOME Text Editor/Calculator, Satty, hyprpicker,
PipeWire/PulseAudio tools (`pactl`), `socat`, Python 3, and `notify-send`. Install
Zellij for Alacritty's default shell and the Nerd Fonts named in the terminal
configs. Handy is optional; its AppImage is not included.

Preview the exact files, then install when ready:

```sh
./install-linux.sh
./install-linux.sh --apply
```

The installer copies the files in [the Linux manifest](profiles/linux-files.txt).
It backs up replaced files under `~/.dotfiles_backup_<timestamp>/`, preserving
relative paths. It copies files individually so theme generation and application
writes remain outside this repository. It does not install packages or reload the
running desktop. `--target /path/to/test-home` supports a separate destination.

Before using the desktop, edit `config/variables.lua` for applications and
`config/monitors.lua` for your monitor. The supplied 4K/240 Hz mode is a hardware
preference; change it to `preferred` for a different display. Add `~/.local/bin`
to your graphical session's PATH for the helper commands.

After installation, enable the plugins in Noctalia Settings → Plugins, or run:

```sh
noctalia msg plugins enable local/scratch-workspace-indicator
noctalia msg plugins enable local/audio-output-cycle
```

The plugins use neutral public IDs, so they must be enabled separately from any
existing private copies. Manage older copies in Noctalia Settings. The bounded
lock/display recovery helper is retained, but its temporary diagnostic collector
is excluded. The helper preserves the session lock and writes diagnostic output
only under `~/.local/state/`.

## macOS and older desktops

`./install.sh` installs the Brewfile and applies `macos.sh`. It uses the separate
[macOS manifest](profiles/macos-files.txt) and retains the original Zsh profile
under `.config/zsh/macos.zshrc`. Existing files receive individual backups; the
installer does not replace the whole `.config` directory. The macOS installation
has not been exercised on this Linux host.
On Linux, `./install.sh` forwards to the preview-first Linux installer.

Older i3, Redshift, and GNOME shortcut configs remain available but are not part
of the Hyprland install. Redshift uses GeoClue instead of fixed coordinates; i3's
Bluetooth shortcut opens the device manager instead of storing a device address.

## Keep private settings local

Use `~/.zshrc.local` and `~/.config/fish/config.fish.local` for credentials,
provider exports, remote-machine aliases, and machine-specific settings. These
files are ignored. Use environment variables or the OS keyring for secret values.
Do not copy whole `.config`, `.local`, browser, cloud, or AI application folders.

Run both checks before committing:

```sh
python3 scripts/check-public-configs.py
gitleaks dir --redact --no-banner .
gitleaks git --log-opts=--all --redact --no-banner .
git config core.hooksPath .config/git-hooks
```

The pre-commit hook checks the exact staged contents for personal identifiers
and credentials, and blocks when its required tools are unavailable. GitHub
Actions runs the privacy and credential checks too. For details and limitations,
see [SECURITY.md](SECURITY.md).

## License

See [LICENSE](LICENSE) for the repository's GPL v3 license. Bundled shaders and
plugins retain their own license notices.
