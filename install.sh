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

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    error "This script is designed for macOS only"
    exit 1
fi

# Install Xcode Command Line Tools if not installed
if ! xcode-select -p &>/dev/null; then
    log "Installing Xcode Command Line Tools..."
    xcode-select --install
    success "Xcode Command Line Tools installed"
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Homebrew installed"
fi

# Make sure we're using the latest Homebrew
log "Updating Homebrew..."
brew update

# Install all dependencies from Brewfile
log "Installing packages from Brewfile..."
brew bundle

# Create necessary directories
log "Creating necessary directories..."
mkdir -p ~/.config

# Backup existing files
timestamp=$(date +%Y%m%d_%H%M%S)
backup_dir="$HOME/.dotfiles_backup_$timestamp"
mkdir -p "$backup_dir"

# Function to backup and symlink
backup_and_link() {
    local source="$1"
    local target="$2"
    
    # Backup existing file/directory if it exists
    if [ -e "$target" ]; then
        mv "$target" "$backup_dir/"
    fi
    
    # Create symlink
    ln -sf "$source" "$target"
}

# Symlink configuration files
log "Creating symlinks..."
backup_and_link "$PWD/.zshrc" "$HOME/.zshrc"
backup_and_link "$PWD/.config" "$HOME/.config"

# Apply macOS settings
log "Applying macOS settings..."
source ./macos.sh

success "Installation complete! Please restart your computer for all changes to take effect."
echo "Your old configuration files have been backed up to: $backup_dir" 