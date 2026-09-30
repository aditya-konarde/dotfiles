#!/bin/bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$repo_dir"

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

# Route Linux to the manifest installer; package installation remains separate.
if [[ "$(uname)" != "Darwin" ]]; then
    exec "$repo_dir/install-linux.sh" "$@"
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

# Copy only reviewed files; application state and credentials stay outside Git.
log "Installing public configuration files..."
python3 "$repo_dir/scripts/install-files.py" \
    --manifest "$repo_dir/profiles/macos-files.txt" --apply

# Keep hook configuration local to this checkout.
git config --local core.hooksPath .config/git-hooks

# Apply macOS settings
log "Applying macOS settings..."
source ./macos.sh

success "Installation complete! Please restart your computer for all changes to take effect."
