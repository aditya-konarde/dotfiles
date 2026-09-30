# Public configuration policy

This repository contains reviewed settings and helper source. Never add account
files, tokens, private keys, histories, device identifiers, exact location,
private remote hosts, or application/session state. Git author metadata remains
public when commits are published; configure your author identity separately.

## Checks

Gitleaks scans credentials. `scripts/check-public-configs.py` adds checks for
personal home paths, email addresses, MAC addresses, fixed coordinates, private
network addresses, SSH accounts/hosts, URL credentials, and common private files.
It reports only filenames, line numbers, and categories, never matching values.

Use both tools: a clean Gitleaks result alone does not establish privacy. Neither
check can recognize every identifier or secret. Manually review new files, URLs,
commands, and comments before publication. No broad Gitleaks allowlist is used.

The pre-commit hook checks index contents, including newly added files. Configure
it with `git config core.hooksPath .config/git-hooks`; it requires Gitleaks and
Python 3. CI also checks the current files and scans Git history for credentials.
The installers copy explicit manifests and do not link live app directories into
this public checkout.

## Local settings and exclusions

Keep credentials and remote hosts in ignored `~/.zshrc.local` or
`~/.config/fish/config.fish.local`, environment variables, or your OS keyring.
Keep Git identities, browser profiles, cloud/SSH credentials, Noctalia plugin
activation state, diagnostic captures, and application data outside the repo.
`.gitignore` excludes common private paths and backup files, but already tracked
files remain tracked even if an ignore rule matches them.

## Reporting

For exposed credentials or other sensitive findings, contact the repository
owner privately via GitHub. Include the affected path and commit, but do not copy
secret values into public issues. Ordinary configuration problems can be reported
in a public issue.
