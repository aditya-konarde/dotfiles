#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
exec python3 "$repo_dir/scripts/install-files.py" \
    --manifest "$repo_dir/profiles/linux-files.txt" "$@"
