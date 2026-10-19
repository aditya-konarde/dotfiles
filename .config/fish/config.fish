source /usr/share/cachyos-fish-config/cachyos-config.fish

# Fix kitty terminal compatibility with sudo/systemctl
set -gx TERM xterm-256color

# overwrite greeting
function fish_greeting
end
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

# opencode
fish_add_path $HOME/.opencode/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# Added by LM Studio CLI tool (lms)
fish_add_path $HOME/.lmstudio/bin

# Railway CLI
fish_add_path $HOME/.railway/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Downloads/google-cloud-sdk/path.fish.inc" ]; . "$HOME/Downloads/google-cloud-sdk/path.fish.inc"; end

# Entire CLI shell completion
entire completion fish | source

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

# Secret helpers (GNOME Keyring)
function create-secret --description "Store a secret: create-secret <name> <value>"
    echo -n $argv[2] | secret-tool store --label="$argv[1]" service secrets key $argv[1]
    echo "Stored secret '$argv[1]'"
end

function read-secret --description "Read a secret: read-secret <name>"
    secret-tool lookup service secrets key $argv[1]
end

set -gx Z_AI_API_KEY (read-secret zai)

set -gx ANTHROPIC_BASE_URL "http://localhost:1234"
set -gx ANTHROPIC_AUTH_TOKEN "lmstudio"

#set -gx ANTHROPIC_AUTH_TOKEN "$OPENROUTER_API_KEY"
#set -gx ANTHROPIC_API_KEY ""

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


# Added by Antigravity CLI installer
set -gx PATH "$HOME/.local/bin" $PATH

# gcx: opt out of anonymous usage telemetry (honored by gcx >= 1.0)
set -gx GCX_TELEMETRY disabled
