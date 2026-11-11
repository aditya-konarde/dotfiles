#!/usr/bin/env python3
"""Copy an explicit config manifest, backing up each replaced file separately.

Entries may end with `[template]`, which expands `$HOME` to the target home
while installing so tracked files can reference the user's own directories.
"""

import argparse
from datetime import datetime
import os
from pathlib import Path
import shutil
import tempfile


TEMPLATE_FLAG = "[template]"


def manifest_entries(manifest, repo, target):
    """Parse and validate installer source and destination paths."""
    entries = []
    for line in manifest.read_text().splitlines():
        if not line or line.startswith("#"):
            continue
        source_name, _, remainder = line.partition(" -> ")
        destination_name, _, flags = remainder.partition(" ")
        if flags and flags != TEMPLATE_FLAG:
            raise ValueError(f"unknown manifest flag: {line}")
        source_rel = Path(source_name)
        dest_rel = Path(destination_name or source_name)
        if any(p.is_absolute() or ".." in p.parts for p in (source_rel, dest_rel)):
            raise ValueError(f"invalid manifest entry: {line}")
        source = repo / source_rel
        dest = target / dest_rel
        if source.is_symlink() or not source.is_file():
            raise ValueError(f"missing or symlinked source: {source_rel}")
        if not source.resolve().is_relative_to(repo):
            raise ValueError(f"source escapes the repository: {source_rel}")
        if not dest.parent.resolve().is_relative_to(target):
            raise ValueError(f"destination parent escapes target via a symlink: {dest_rel}")
        if dest.exists() and not dest.is_file():
            raise ValueError(f"destination is not a file: {dest_rel}")
        entries.append((source, dest, dest_rel, flags == TEMPLATE_FLAG))
    return entries


def rendered_bytes(source, target, template):
    """Return the content to install, expanding $HOME for template entries."""
    data = source.read_bytes()
    if not template:
        return data
    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError as error:
        raise ValueError(f"template source is not UTF-8 text: {source.name}") from error
    return text.replace("$HOME", str(target)).encode("utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", required=True, type=Path)
    parser.add_argument("--target", type=Path, default=Path.home())
    parser.add_argument("--apply", action="store_true", help="write files (default: preview only)")
    args = parser.parse_args()
    repo = Path(__file__).resolve().parent.parent
    target = args.target.expanduser().resolve()
    try:
        entries = manifest_entries(args.manifest, repo, target)
    except ValueError as error:
        parser.error(str(error))
    if not args.apply:
        for _, _, rel, _ in entries:
            print(f"Would copy {rel}")
        print(f"Preview only: {len(entries)} files. Use --apply to install.")
        return
    try:
        contents = [rendered_bytes(source, target, template) for source, _, _, template in entries]
    except ValueError as error:
        parser.error(str(error))
    target.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
    backup = target / f".dotfiles_backup_{stamp}"
    backup.mkdir(mode=0o700)
    for (source, dest, rel, _), content in zip(entries, contents):
        if dest.is_file() and not dest.is_symlink() and content == dest.read_bytes():
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        # Write first, then rename. An interrupted copy leaves the old file intact.
        fd, temporary = tempfile.mkstemp(prefix=".dotfiles-", dir=dest.parent)
        os.close(fd)
        try:
            Path(temporary).write_bytes(content)
            shutil.copystat(source, temporary)
            if dest.exists() or dest.is_symlink():
                saved = backup / rel
                saved.parent.mkdir(parents=True, exist_ok=True)
                dest.rename(saved)
            os.replace(temporary, dest)
        finally:
            Path(temporary).unlink(missing_ok=True)
        print(f"Installed {rel}")
    print(f"Backups: {backup}")


if __name__ == "__main__":
    main()
