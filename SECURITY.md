# Security Policy

## About This Repository

This is a personal dotfiles repository containing shell configurations, application settings, and system setup scripts. While this repository does not contain application code, security is still important.

## Reporting a Vulnerability

If you discover a security issue (such as accidentally committed secrets, insecure configurations, or other concerns), please report it responsibly.

### How to Report

- **For minor issues**: Open a GitHub issue
- **For sensitive issues** (e.g., exposed credentials): Please contact the repository owner directly via GitHub

### What to Include

- Description of the security concern
- Location of the affected file(s)
- Suggested remediation (if applicable)

## Security Best Practices

This repository follows these security practices:

### Excluded from Version Control

The following are excluded via `.gitignore`:
- SSH private keys (`id_rsa`, `id_ed25519`, etc.)
- GPG private keys
- Environment files (`.env`, `.env.*`)
- Shell history files
- API keys and tokens
- Cloud provider credentials
- Application secrets

### What IS Tracked

Only configuration files that do not contain secrets:
- Shell configuration (`.zshrc`)
- Application preferences
- Setup scripts
- Homebrew package lists

## Security Checklist for Contributors

If you fork or contribute to this repository:

- [ ] Never commit secrets, tokens, or passwords
- [ ] Use environment variables for sensitive configuration
- [ ] Review changes before committing
- [ ] Keep local copies of sensitive files outside the repo

## Acknowledgments

Security researchers and contributors who help improve this repository's security are appreciated.
