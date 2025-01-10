# Dotfiles

A collection of dotfiles and scripts for setting up a macOS development environment.

## Features

- Automated installation script
- macOS system preferences and settings
- Homebrew package management with Brewfile
- ZSH configuration
- Various development tool configurations

## Prerequisites

- macOS (tested on macOS Sonoma)
- Git (for cloning this repository)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

The installation script will:
- Install Xcode Command Line Tools if not present
- Install Homebrew if not present
- Install all packages from the Brewfile
- Backup existing dotfiles
- Create symbolic links for all dotfiles
- Configure macOS settings

## What's Included

- `.zshrc`: ZSH shell configuration
- `.config/`: Various tool configurations
- `Brewfile`: Homebrew packages and applications
- `macos.sh`: macOS system preferences
- `install.sh`: Main installation script

## Post-Installation

After installation:
1. Restart your computer to apply all settings
2. Open iTerm2 (it will be installed via Homebrew)
3. Your old configuration files will be backed up in `~/.dotfiles_backup_[timestamp]`

## Customization

Feel free to fork this repository and modify any of the files to match your preferences:
- Edit the `Brewfile` to add/remove packages
- Modify `macos.sh` to change system preferences
- Update `.zshrc` for shell customization

## License

This project is licensed under the MIT License - see the LICENSE file for details.
