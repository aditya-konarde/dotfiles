#!/usr/bin/env python3
"""Compare the Linux manifest with a target home without changing either."""

import argparse
import importlib.util
from pathlib import Path
import sys


def main():
    repo = Path(__file__).resolve().parent.parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--target", type=Path, default=Path.home(), help="home to compare")
    parser.add_argument("--manifest", type=Path, default=repo / "profiles/linux-files.txt")
    args = parser.parse_args()
    sys.dont_write_bytecode = True
    spec = importlib.util.spec_from_file_location("install_files", repo / "scripts/install-files.py")
    installer = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(installer)
    try:
        entries = installer.manifest_entries(args.manifest, repo, args.target.expanduser().resolve())
        differences = 0
        for source, dest, relative in entries:
            if dest.is_symlink():
                print(f"Symlink: {relative}")
                differences += 1
            elif not dest.is_file():
                print(f"Missing: {relative}")
                differences += 1
            elif source.read_bytes() != dest.read_bytes():
                print(f"Drift: {relative}")
                differences += 1
        print(f"Compared {len(entries)} files: {differences} differences.")
        return int(bool(differences))
    except (OSError, ValueError) as error:
        print(f"Drift check error: {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
