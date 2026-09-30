#!/usr/bin/env python3
"""Copy an explicit config manifest, backing up each replaced file separately."""

import argparse
from datetime import datetime
import os
from pathlib import Path
import shutil
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", required=True, type=Path)
    parser.add_argument("--target", type=Path, default=Path.home())
    parser.add_argument("--apply", action="store_true", help="write files (default: preview only)")
    args = parser.parse_args()
    repo = Path(__file__).resolve().parent.parent
    target = args.target.expanduser().resolve()
    entries = []
    for line in args.manifest.read_text().splitlines():
        if not line or line.startswith("#"):
            continue
        source_name, _, destination_name = line.partition(" -> ")
        source_rel = Path(source_name)
        dest_rel = Path(destination_name or source_name)
        if any(p.is_absolute() or ".." in p.parts for p in (source_rel, dest_rel)):
            parser.error(f"invalid manifest entry: {line}")
        source = repo / source_rel
        dest = target / dest_rel
        if source.is_symlink() or not source.is_file():
            parser.error(f"missing or symlinked source: {source_rel}")
        if not source.resolve().is_relative_to(repo):
            parser.error(f"source escapes the repository: {source_rel}")
        if not dest.parent.resolve().is_relative_to(target):
            parser.error(f"destination parent escapes target via a symlink: {dest_rel}")
        if dest.exists() and not dest.is_file():
            parser.error(f"destination is not a file: {dest_rel}")
        entries.append((source, dest, dest_rel))
    if not args.apply:
        for _, _, rel in entries:
            print(f"Would copy {rel}")
        print(f"Preview only: {len(entries)} files. Use --apply to install.")
        return
    target.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
    backup = target / f".dotfiles_backup_{stamp}"
    backup.mkdir(mode=0o700)
    for source, dest, rel in entries:
        if dest.is_file() and not dest.is_symlink() and source.read_bytes() == dest.read_bytes():
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        # Copy first, then rename. An interrupted copy leaves the old file intact.
        fd, temporary = tempfile.mkstemp(prefix=".dotfiles-", dir=dest.parent)
        os.close(fd)
        try:
            shutil.copy2(source, temporary)
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
