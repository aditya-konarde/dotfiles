if test -r /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# Fix kitty terminal compatibility with sudo/systemctl
set -gx TERM xterm-256color

# overwrite greeting
function fish_greeting
end
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

# opencode
fish_add_path ~/.opencode/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# Added by LM Studio CLI tool (lms)

# Railway CLI
fish_add_path $HOME/.railway/bin

# The next line updates PATH for the Google Cloud SDK.
if test -f "$HOME/Downloads/google-cloud-sdk/path.fish.inc"
    source "$HOME/Downloads/google-cloud-sdk/path.fish.inc"
end

# Entire CLI shell completion
if type -q entire
    entire completion fish | source
end

if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
end

# ROCm / HIPBlas (Strix Halo - gfx1151)
set -gx ROCM_PATH /opt/rocm
fish_add_path /opt/rocm/bin
set -gx HSA_OVERRIDE_GFX_VERSION 11.5.1
set -gx PYTORCH_ROCM_ARCH gfx1151
set -gx HSA_XNACK 1
set -gx ROCBLAS_USE_HIPBLASLT 1
fish_add_path ~/go/bin

# Credentials and machine-specific exports belong in this ignored local file.
if test -r "$HOME/.config/fish/config.fish.local"
    source "$HOME/.config/fish/config.fish.local"
end

# Auto-start Zellij if available and not already inside a session
if type -q zellij; and not set -q ZELLIJ; and status is-interactive
    exec zellij
end
