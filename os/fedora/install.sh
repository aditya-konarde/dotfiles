#!/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}==>${NC} $1"
}

error() {
    echo -e "${RED}==>${NC} $1"
}

if ! grep -q "Fedora" /etc/os-release; then
    error "This script is designed for Fedora only"
    exit 1
fi

log "Installing packages from packages.txt..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PACKAGES=$(grep -v '^#' "$SCRIPT_DIR/packages.txt" | grep -v '^$')

if command -v sudo &>/dev/null; then
    sudo dnf update -y
    echo "$PACKAGES" | xargs sudo dnf install -y
else
    error "sudo is not available. Please run as root or install sudo."
    exit 1
fi

success "Package installation complete!"
