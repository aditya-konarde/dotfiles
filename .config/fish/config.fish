source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
function fish_greeting
end
fish_add_path $HOME/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# Go
fish_add_path ~/go/bin

# Linuxbrew
if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
end

# ROCm / HIPBlas (Strix Halo - gfx1151)
set -gx ROCM_PATH /opt/rocm
fish_add_path /opt/rocm/bin
set -gx HSA_OVERRIDE_GFX_VERSION 11.5.1
set -gx PYTORCH_ROCM_ARCH gfx1151
set -gx HSA_XNACK 1
set -gx ROCBLAS_USE_HIPBLASLT 1

# Secret helpers (GNOME Keyring)
# Usage: create-secret <name> <value>  →  stores in OS keyring
#        read-secret <name>            →  retrieves from OS keyring
function create-secret --description "Store a secret: create-secret <name> <value>"
    echo -n $argv[2] | secret-tool store --label="$argv[1]" service secrets key $argv[1]
    echo "Stored secret '$argv[1]'"
end

function read-secret --description "Read a secret: read-secret <name>"
    secret-tool lookup service secrets key $argv[1]
end

# Load local overrides (API keys, machine-specific env vars)
# Put credential exports in ~/.config/fish/config.fish.local
if test -f ~/.config/fish/config.fish.local
    source ~/.config/fish/config.fish.local
end
