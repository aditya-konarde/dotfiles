#!/usr/bin/env python3
"""Check public config files for private paths and common personal identifiers.

Run alongside Gitleaks: this check detects personal data, not every secret.
Diagnostics contain filenames and line numbers, never matching values.
"""

import argparse
import os
from pathlib import Path
import re
import subprocess
import sys


RULES = {
    "personal home directory": re.compile(
        r"/(?:home|Users)/(?!linuxbrew(?:/|\b)|username(?:/|\b)|user(?:/|\b)|\$)[^/\s\"']+"
    ),
    "email address": re.compile(r"\b[\w.+-]+@[\w.-]+\.[A-Za-z]{2,}\b"),
    "MAC address": re.compile(r"\b(?:[\da-fA-F]{2}:){5}[\da-fA-F]{2}\b"),
    "fixed geographic location": re.compile(
        r"(?im)^\s*(?:lat|lon|latitude|longitude)\s*[=:]\s*-?\d"
    ),
    "private network address": re.compile(
        r"\b(?:10\.\d{1,3}|192\.168|172\.(?:1[6-9]|2\d|3[01]))\.\d{1,3}\.\d{1,3}\b"
    ),
    "private remote host": re.compile(r"[\w-]+\.(?:exe\.xyz|ts\.net|tailscale\.net)\b"),
    "SSH account or host": re.compile(r"\b(?:ssh|scp|sftp)\s+[^\n]*\b[\w.-]+@[\w.-]+"),
    "URL credentials": re.compile(r"https?://[^\s/\"']+:[^\s/\"']+@"),
}
PRIVATE_DIRS = {".ssh", ".gnupg", ".aws", ".azure", ".cache"}
PRIVATE_NAMES = {
    "auth.json", "hosts.yml", "credentials", "credentials.json", "oauth.json",
    "credentials.toml", "credentials.yaml", "credentials.yml", ".git-credentials",
    ".netrc", ".pypirc",
    "secrets.json", "secrets.yaml", "secrets.yml", "fish_variables", ".gitconfig",
    ".zsh_history", ".bash_history", "known_hosts",
}


def git(*args):
    return subprocess.check_output(["git", *args])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--staged", action="store_true", help="check the exact index contents")
    args = parser.parse_args()
    root = Path(git("rev-parse", "--show-toplevel").decode().strip())
    os.chdir(root)
    options = ["ls-files", "-z", "--cached"]
    if not args.staged:
        options += ["--others", "--exclude-standard"]
    paths = sorted(set(p for p in git(*options).decode().split("\0") if p))
    findings = []
    scanned = 0
    for name in paths:
        path = Path(name)
        if PRIVATE_DIRS.intersection(path.parts) or path.name in PRIVATE_NAMES or (
            path.name == ".env" or path.name.startswith(".env.")
            or ".local" in path.suffixes or name.startswith(".local/state/")
            or name.startswith(".config/git/")
        ):
            findings.append(f"{name}: private file or directory")
            continue
        if args.staged:
            mode = git("ls-files", "-s", "--", name).decode().split()[0]
            if mode == "120000":
                findings.append(f"{name}: symbolic links must be reviewed as regular files")
                continue
            data = git("show", f":{name}")
        else:
            source = root / name
            if source.is_symlink():
                findings.append(f"{name}: symbolic links must be reviewed as regular files")
                continue
            if not source.is_file():
                continue
            data = source.read_bytes()
        scanned += 1
        try:
            contents = data.decode("utf-8")
        except UnicodeDecodeError:
            findings.append(f"{name}: binary file requires manual privacy review")
            continue
        for number, line in enumerate(contents.splitlines(), 1):
            for reason, pattern in RULES.items():
                if pattern.search(line):
                    findings.append(f"{name}:{number}: {reason}")
    for finding in findings:
        print(finding, file=sys.stderr)
    print(f"Privacy check: {scanned} files, {len(findings)} findings.")
    return int(bool(findings))


if __name__ == "__main__":
    sys.exit(main())
