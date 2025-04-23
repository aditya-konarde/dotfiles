# Secret Management

This directory contains templates for secret files, but NOT the actual secrets.

## Strategy

1. All actual secret files should be stored in `~/.secrets/` directory (not tracked by git)
2. Secret templates are stored here with `.template` extension
3. The installation script will copy these templates to `~/.secrets/` if they don't exist
4. Your shell configuration sources these secret files

## Available Templates

- `api_keys.template.sh`: Template for API keys
- `ssh_config.template`: Template for SSH configuration
- `aws_credentials.template`: Template for AWS credentials

## Usage

1. Copy a template to `~/.secrets/`: `cp api_keys.template.sh ~/.secrets/api_keys.sh`
2. Edit the file to add your actual secrets: `vim ~/.secrets/api_keys.sh`
3. The main configuration will automatically source these files
