# Keep the macOS shell profile while using the current CachyOS profile on Linux.
if [[ "$OSTYPE" == darwin* ]]; then
  [[ -r "$HOME/.config/zsh/macos.zshrc" ]] && source "$HOME/.config/zsh/macos.zshrc"
  return
fi

# CachyOS initializes Oh My Zsh, Powerlevel10k, and the instant prompt.
[[ -r /usr/share/cachyos-zsh-config/cachyos-config.zsh ]] &&
  source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Disable command auto-correction (the "correct 'x' to 'y' [nyae]?" prompts).
# CachyOS's config enables it via ENABLE_CORRECTION; turn it back off here so
# it survives updates to the system config.
unsetopt correct correct_all

# Homebrew also configures MANPATH and INFOPATH, so initialize it before
# defining the preferred order of user-local executable directories.
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# Keep PATH entries unique and declare their precedence in one place.
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.docker/sbx/bin"
  "$HOME/.npm-global/bin"
  "$HOME/.cargo/bin"
  "$HOME/.railway/bin"
  "$HOME/.bun/bin"
  $path
)

# CachyOS's config enables zsh spelling correction, which is useful for commands
# but noisy for hostnames, URLs, and remote paths. Exempt network commands only.
for _nc in ssh scp sftp sshfs rsync mosh ssh-add ssh-copy-id ssh-keygen ssh-keyscan curl wget; do
  alias "$_nc"="nocorrect $_nc"
done
unset _nc

# Prefer the installed GSD CLI over the git plugin's `gsd='git svn dcommit'` alias.
unalias gsd 2>/dev/null || true

# Mount APFS drive easily
mount-mac() {
    local drive=$(lsblk -p -n -l -o NAME,FSTYPE | grep -i apfs | awk '{print $1}' | head -n 1)
    if [ -z "$drive" ]; then
        echo "No APFS drive detected."
        return 1
    fi
    local mount_point="/run/media/$USER/MacDrive"
    echo "Found APFS drive at $drive. Mounting to $mount_point..."
    sudo mkdir -p "$mount_point"
    sudo chown "$USER:$USER" "$mount_point"
    sudo apfs-fuse -o allow_other "$drive" "$mount_point"
    if [ $? -eq 0 ]; then
        echo "Successfully mounted! You can now access it in GNOME Files or at $mount_point"
    else
        echo "Failed to mount the drive."
    fi
}

unmount-mac() {
    local mount_point="/run/media/$USER/MacDrive"
    echo "Unmounting $mount_point..."
    sudo umount "$mount_point"
    if [ $? -eq 0 ]; then
        echo "Successfully unmounted."
    else
        echo "Failed to unmount. Ensure no applications are using the drive."
    fi
}

# Bun
export BUN_INSTALL="$HOME/.bun"
[[ -r "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# Secret helpers (GNOME Keyring)
create-secret() {
    if (( $# != 1 )); then
        echo "Usage: create-secret <name>" >&2
        return 2
    fi
    if ! command -v secret-tool >/dev/null 2>&1; then
        echo "secret-tool not found" >&2
        return 127
    fi

    local name="$1"
    local value

    if [[ -t 0 ]]; then
        read -rs "value?Secret value for '$name': "
        echo
    else
        IFS= read -r value || [[ -n "$value" ]]
    fi

    if [[ -z "$value" ]]; then
        echo "Secret value cannot be empty" >&2
        return 2
    fi

    printf '%s' "$value" | command secret-tool store --label="$name" service secrets key "$name"
    local status=$?
    value=''

    if (( status == 0 )); then
        echo "Stored secret '$name'"
    fi
    return $status
}

read-secret() {
    if [ $# -ne 1 ]; then
        echo "Usage: read-secret <name>" >&2
        return 2
    fi
    if ! command -v secret-tool >/dev/null 2>&1; then
        echo "secret-tool not found" >&2
        return 127
    fi

    command secret-tool lookup service secrets key "$1"
}

# Auto-Warpify
if [[ -o interactive && "${TERM_PROGRAM:-}" == WarpTerminal ]]; then
    printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh", "uname": "Linux" }}\x9c'
fi

# >>> railway initialize >>>
[[ -r "$HOME/.railway/env" ]] && source "$HOME/.railway/env"
# <<< railway initialize <<<

# Terminal & Editor defaults
export TERMINAL="kitty"
export EDITOR="zed --wait"
export VISUAL="zed --wait"

# Aliases for modern Rust CLI tools
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons"
  alias ll="eza -lh --icons --git"
  alias la="eza -lah --icons --git"
  alias tree="eza --tree --icons"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat --paging=never"
fi

if command -v bottom >/dev/null 2>&1; then
  alias top="btm"
fi

# Starship Prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Credentials, remote hosts, and machine-specific aliases stay in this local file.
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
