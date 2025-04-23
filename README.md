# Dotfiles

A comprehensive, cross-platform dotfiles repository for setting up a development environment on macOS and Fedora Linux.

## Features

- **Cross-Platform Support**: Works on both macOS and Fedora Linux
- **Modular Organization**: Configuration files are split into logical components
- **Automated Installation**: One-command setup with intelligent OS detection
- **Package Management**: 
    - macOS: Homebrew with Brewfile
    - Fedora: DNF with package list
- **Shell Configuration**: Optimized ZSH setup with aliases, functions, and more
- **Window Manager**: i3 configuration for Linux
- **Secret Management**: Secure handling of API keys and sensitive information
- **Git Configuration**: Sensible defaults with local overrides

## Directory Structure

```
.
├── bin/                  # Custom scripts and executables
├── config/               # Application configurations
│   ├── i3/               # i3 window manager config
│   └── redshift/         # Redshift (blue light filter) config
├── git/                  # Git configuration
│   ├── gitconfig         # Global git config
│   └── gitignore_global  # Global gitignore
├── os/                   # OS-specific settings
│   ├── macos/            # macOS specific files
│   │   ├── Brewfile      # Homebrew packages
│   │   └── macos.sh      # macOS system preferences
│   └── fedora/           # Fedora specific files
│       ├── install.sh    # Fedora package installer
│       └── packages.txt  # List of packages to install
├── secrets/              # Templates for secret files (actual secrets not tracked)
├── shell/                # Shell configuration files
│   ├── aliases.zsh       # Command aliases
│   ├── exports.zsh       # Environment variables
│   ├── functions.zsh     # Shell functions
│   ├── history.zsh       # History settings
│   ├── prompt.zsh        # Shell prompt configuration
│   └── zshrc             # Main zsh configuration file
└── install.sh            # Main installation script
```

## Prerequisites

- macOS (Monterey or newer) or Fedora Linux (35+)
- Git (for cloning this repository)
- For Fedora: Basic development tools (`sudo dnf groupinstall "Development Tools"`)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/aditya-konarde/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

The installation script will:
- Detect your operating system
- Install required packages (Homebrew + Brewfile on macOS, DNF packages on Fedora)
- Backup existing dotfiles
- Create symbolic links for all configuration files
- Configure OS-specific settings
- Set up secret management templates

## Customization

### Local Overrides

You can create local override files that won't be tracked by git:

- `~/.zshrc.local`: Local ZSH settings
- `~/.gitconfig.local`: Local Git configuration

### OS-Specific Customization

- **macOS**: Edit `os/macos/Brewfile` to add/remove packages and `os/macos/macos.sh` for system preferences
- **Fedora**: Edit `os/fedora/packages.txt` to modify the list of packages to install

### Secret Management

1. Templates for secrets are in the `secrets/` directory
2. During installation, these templates are copied to `~/.secrets/`
3. Edit the files in `~/.secrets/` to add your actual secrets
4. These files are automatically sourced by your shell configuration

## Components

### Shell

The ZSH configuration is split into modular components:

- **aliases.zsh**: Command shortcuts
- **functions.zsh**: Utility functions
- **exports.zsh**: Environment variables
- **history.zsh**: History settings
- **prompt.zsh**: Shell prompt configuration

### Git

The Git configuration provides:

- Useful aliases (`git co`, `git st`, etc.)
- Sensible defaults
- Local override support via `~/.gitconfig.local`

### Modern CLI Tools

The setup includes modern replacements for traditional Unix tools:

- `bat` instead of `cat`
- `eza` instead of `ls`
- `fd` instead of `find`
- `ripgrep` instead of `grep`

## Updating

To update your dotfiles:

1. Pull the latest changes:
   ```bash
   cd ~/path/to/dotfiles
   git pull
   ```

2. Run the installation script again:
   ```bash
   ./install.sh
   ```

The script is idempotent and can be run multiple times without issues.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
