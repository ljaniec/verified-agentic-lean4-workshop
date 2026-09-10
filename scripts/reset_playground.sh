#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command git
cd "$REPOSITORY_ROOT"

if [[ -d playground/current ]]; then
  bash "$REPOSITORY_ROOT/scripts/scenario.sh" clean
fi

# Restore only tracked playground documentation/examples. Runtime state lives in
# ignored `playground/current/` and `playground/backups/` directories.
if git ls-files -- 'playground/*' | grep -q .; then
  git restore --source=HEAD --worktree -- playground
fi

log "Playground runtime state reset; active work was backed up before removal"
