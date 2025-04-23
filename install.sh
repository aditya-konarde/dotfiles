#!/bin/bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}==>${NC} $1"
}

error() {
    echo -e "${RED}==>${NC} $1"
}

# Get the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

# Create necessary directories
mkdir -p ~/.config ~/.local/bin ~/.secrets

# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
    OS="macos"
elif grep -q "Fedora" /etc/os-release 2>/dev/null; then
    OS="fedora"
else
    error "Unsupported OS. This script supports macOS and Fedora."
    exit 1
fi

log "Detected OS: $OS"

# Install OS-specific packages
log "Installing OS-specific packages..."
if [[ "$OS" == "macos" ]]; then
    # Check if Homebrew is installed
    if ! command -v brew &>/dev/null; then
        log "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        success "Homebrew installed"
    fi

    # Install from Brewfile
    log "Installing packages from Brewfile..."
    cd "$DOTFILES_DIR/os/macos"
    brew bundle

    # Apply macOS settings
    log "Applying macOS settings..."
    bash "$DOTFILES_DIR/os/macos/macos.sh"
elif [[ "$OS" == "fedora" ]]; then
    log "Installing Fedora packages..."
    bash "$DOTFILES_DIR/os/fedora/install.sh"
fi

# Check if GNU Stow is installed
if ! command -v stow &>/dev/null; then
    if [[ "$OS" == "macos" ]]; then
        brew install stow
    elif [[ "$OS" == "fedora" ]]; then
        sudo dnf install -y stow
    fi
fi

# Backup existing files
log "Backing up existing dotfiles..."
timestamp=$(date +%Y%m%d_%H%M%S)
backup_dir="$HOME/.dotfiles_backup_$timestamp"
mkdir -p "$backup_dir"

# Backup existing files that will be replaced
for file in .zshrc .gitconfig .gitignore_global; do
    if [[ -f "$HOME/$file" ]]; then
        cp "$HOME/$file" "$backup_dir/"
    fi
done

# Copy config files to the right locations
log "Setting up configuration files..."

# Setup shell configuration
log "Setting up shell configuration..."
ln -sf "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"

# Setup git configuration
log "Setting up git configuration..."
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

# Setup application specific configurations
log "Setting up application configurations..."
mkdir -p "$HOME/.config/i3"
ln -sf "$DOTFILES_DIR/config/i3/config" "$HOME/.config/i3/config"
mkdir -p "$HOME/.config/redshift"
ln -sf "$DOTFILES_DIR/config/redshift/redshift.conf" "$HOME/.config/redshift/redshift.conf"

# Setup secrets directory
log "Setting up secrets templates..."
mkdir -p "$HOME/.secrets"
for template in "$DOTFILES_DIR"/secrets/*.template.*; do
    filename=$(basename "$template")
    # Remove .template from the filename
    target_file="$HOME/.secrets/${filename/.template/}"
    # Only copy if it doesn't exist yet
    if [[ ! -f "$target_file" ]]; then
        cp "$template" "$target_file"
        log "Created template $target_file. Please edit with your actual secrets."
    fi
done

# Setup is complete
success "Dotfiles installation complete!"
echo "Your old configuration files have been backed up to: $backup_dir"
echo "Please restart your shell or run 'source ~/.zshrc' to apply the changes."

# OS-specific post-installation message
if [[ "$OS" == "macos" ]]; then
    echo "For macOS, you may want to restart your computer to apply all system settings."
elif [[ "$OS" == "fedora" ]]; then
    echo "For i3 configuration to take effect, log out and select i3 as your window manager."
fi
