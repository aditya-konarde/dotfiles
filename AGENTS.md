# Agent instructions

## Scope and completion

This public repository stores curated settings. Read `README.md`, `SECURITY.md`,
the install scripts, and the relevant profile manifest before changing anything.

When the user asks to set up a machine, complete the dependency, configuration,
session integration, and verification workflow below. Copying the files is only
one step. Follow up on missing required packages and pending login checks before
calling the setup complete.

When the task is only to edit, review, or publish the repository, work in the
checkout. Do not install packages, apply configs to the host, or reload its desktop
as a side effect. Preserve unrelated working-tree changes and existing workloads.

## Linux setup workflow

Follow these steps in order. Keep a concise checklist of completed and pending
items so another agent can resume without repeating installations or overwrites.

### 1. Inspect the target

- Check `/etc/os-release`, architecture, package manager, the intended user's home,
  current shell, graphical session, compositor version, and installed commands.
  Apply user configs as the intended user, not as root.
- Treat CachyOS/Arch with Hyprland as the reference profile. For another distro,
  resolve package names and supported session integration from that distro's
  repositories and official documentation. Do not run Arch commands blindly.
- Inspect the session's actual launcher and config path. If both `hyprland.conf`
  and `hyprland.lua` exist, establish which file a new login will load.
- Check available display modes and GPU before applying the monitor profile or
  GPU environment variables. Summarize capabilities; keep raw host inventories
  and user/session details outside the public checkout.
- Read manifests for the exact destinations. Identify existing symlinks and
  meaningful local customizations that need preserving alongside the backups.

### 2. Resolve and install dependencies

Derive dependencies from the current configs, plugin manifests, and helper
scripts. The following groups are a starting inventory, not fixed package names:

| Group | Capabilities to check |
| --- | --- |
| Installer | Bash, Python 3.9 or newer, Git |
| Desktop/session | Lua-capable Hyprland and `hyprctl`, Noctalia v5/plugin API 3, UWSM, D-Bus activation environment tools, XWayland/`xhost` if retaining its startup command |
| Session services | A polkit authentication agent, working desktop portals and the Hyprland portal backend |
| Default launchers | Kitty, Dolphin, the configured browser, GNOME Text Editor and Calculator; resolve replacements in `variables.lua` when appropriate |
| Screenshots/plugins | Satty, hyprpicker, `socat`, `pactl`, `notify-send`, Python; clipboard utilities used by enabled features |
| Audio | A working audio server exposing `pactl`; on a fresh PipeWire setup, its session manager and PulseAudio compatibility service |
| Terminal appearance | Fontconfig and the actual Nerd Font families named in the installed Kitty and Alacritty configs |
| Other selected apps | Zsh/Fish, Zellij, Alacritty, btop, Starship, mpv, MangoHud, Micro, GitHub CLI, and enabled shell helpers |
| Optional integrations | Handy AppImage, ChatGPT launcher, developer CLI tools, keyring helpers, and ROCm settings only when requested or applicable |
| Repo maintenance | Python and Gitleaks for the public-config checks and commit hook |

- Check both command availability and compatibility. The reference config was
  validated with Hyprland 0.56.2 and Noctalia 5.1.0; do not assume an older
  `hyprland.conf`-only release supports the Lua API. Use the installed validators.
- Resolve missing commands to packages using the target's package manager. Prefer
  official repositories. Review package availability and the actual install
  transaction before execution. On Arch-family systems, avoid partial upgrades.
- A request to install this setup authorizes its ordinary required dependencies.
  Use the environment's normal privilege/approval mechanism without asking again
  for every package. Follow any explicit user restriction on package changes.
- If installation needs authorization that has not been granted, give one concise
  follow-up with the exact missing packages and the concrete install command.
  Continue independent inspection and preparation while awaiting the response.
- If authentication or privilege access is unavailable, ask the user to run that
  command themselves. Never request their password, bypass privileges, or keep
  retrying the same failed installation. Recheck the commands when they report
  completion; do not treat an unanswered request as an installed dependency.
- Keep a working audio stack and existing session services. Optional AI tools,
  models, AppImages, and GPU runtimes must not become mandatory desktop packages.
  If an optional integration is skipped, disable its active startup/shortcut
  commands and hide unavailable optional launcher entries in the installed config
  so it does not produce repeated failures.
- Do not stop at "install dependencies separately." Resolve required missing
  packages through installation or a concrete user handoff, and track any blocker.

### 3. Preview, back up, and apply

- Run `./install-linux.sh` to preview. Explain the selected profile and any
  adaptations needed for this host. When machine setup is already authorized,
  continue with `./install-linux.sh --apply`.
- For an isolated copy check, use `--target <test-home>`. That checks file
  installation only; it cannot prove a working graphical session.
- Use the manifest installer and retain its reported backup directory. Preserve
  the relative paths of backups. Never replace or symlink the entire `.config`
  directory, copy a whole home directory, or delete the user's old setup.
- Identical files are skipped, but a repeat install overwrites selected files
  changed since installation. Inspect and preserve those local customizations
  before reapplying; do not repeatedly overwrite a user's monitor or app choices.
- Adapt installed configs or an ignored staging copy for host-specific choices.
  Keep monitor identifiers, private paths, and local account settings out of
  tracked templates. Use `preferred` or a verified supported mode instead of
  assuming the supplied 4K/240 Hz profile works everywhere.
- Choose installed application commands in `variables.lua` and check `EDITOR` and
  `VISUAL` in the shell config too. Keep GPU-specific
  Fish/ROCm exports only on the matching hardware. Check the Zellij shell setting
  in Alacritty and the font families with Fontconfig; silent font fallback is not
  proof that the requested fonts are installed.

### 4. Integrate the graphical session

- Ensure `~/.local/bin` is in the graphical session's PATH, not just the terminal's
  PATH. Confirm the installed helpers are executable and resolve by command name.
- Verify the session launcher loads the intended Lua config. Make targeted changes
  to the installed launcher when needed; keep a way to return to the old session.
- Ensure exactly one polkit agent starts with the session. This Noctalia profile
  has `polkit_agent = false`, so a separate agent must be provided. Discover the
  installed service/autostart mechanism instead of guessing unit names.
- Verify portal activation and the Wayland environment. Use distro-supported
  integration; D-Bus-activated/static portal units do not need forced enabling.
- Verify audio session services and `pactl` access without switching outputs as an
  incidental check. Refresh desktop-entry discovery when supported and needed.
- With Noctalia running, inspect the plugin list and enable the public IDs when
  not already enabled:

  ```sh
  noctalia msg plugins enable local/scratch-workspace-indicator
  noctalia msg plugins enable local/audio-output-cycle
  ```

  Confirm activation. Avoid duplicate private/public copies of the same widget
  or service. Modify source plugins, not Noctalia's generated runtime copies.
- Do not unexpectedly log out the user, reboot, restart the compositor, change the
  default shell, or replace the display manager. If a new login is needed, explain
  the specific next action and arrange the verification follow-up.

### 5. Verify the installed result

Run these against the installed files, using the intended user's home:

```sh
Hyprland --verify-config --config "$HOME/.config/hypr/hyprland.lua"
noctalia config validate "$HOME/.config/noctalia/config.toml"
noctalia plugins lint "$HOME/.local/share/noctalia/plugins/audio-output-cycle" \
  "$HOME/.local/share/noctalia/plugins/scratch-workspace-indicator"
zsh -n "$HOME/.zshrc"
fish --no-execute "$HOME/.config/fish/config.fish"
```

Skip a shell check only if that shell/profile was explicitly excluded. Investigate
warnings. Standalone Noctalia validation may not load local plugin types; plugin
lint and activation in the real running session must also pass.

Inside the actual graphical session, check `hyprctl configerrors`, Noctalia status
and plugin activation, the effective monitor mode, portals, polkit, and audio.
Verify a terminal and the configured launchers open, workspace movement and scratch
toggle work, the scratch indicator renders, and the Control Center audio shortcut
is present. Test audio switching or microphone recording only within the user's
requested scope; do not disrupt ongoing playback or start recording implicitly.

If graphical access is unavailable, report "files installed; session verification
pending" and give the exact login/check steps. Follow up with the user to obtain
the outcome and resolve failures. Never label a config-only or headless test as a
successful fresh desktop installation.

The final handoff must state the installed profile, dependencies installed or
substituted, skipped optional integrations, host-specific adaptations, backup and
rollback paths, checks actually completed, and remaining user actions. Rollback
restores only files replaced by this run from their matching backup paths; review
newly created files separately. Do not remove unrelated packages or user data.

## Repository changes and publication

- Keep secrets, identities, host inventories, and machine/session state outside
  this public repository. Use the ignored shell override files for private data.
- Keep the README, manifests, dependency inventory, and agent instructions aligned
  when commands, installed files, or setup requirements change.
- Check manifest entries with `git ls-files`; a file existing on disk does not
  establish that it will be included in a clone. The `.local` exceptions are an
  explicit allowlist; review each addition before broadening it.
- Run `python3 scripts/check-public-configs.py` and
  `gitleaks dir --redact --no-banner .` before publication. Check the exact index
  with `python3 scripts/check-public-configs.py --staged` and
  `gitleaks git --staged --redact --no-banner .` before committing.
- Review diffs for identifiers the scanners cannot recognize. Do not bypass a
  failing hook, print secret values, or add blanket scan exclusions.
- When commit/push is requested, inspect branch and remote state, preserve remote
  changes, and push normally after validation. Report the published commit and
  outstanding remote checks. Do not force-push or rewrite history as routine work.
