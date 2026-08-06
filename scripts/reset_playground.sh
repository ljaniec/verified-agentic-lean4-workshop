#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command git
cd "$REPOSITORY_ROOT"

if [[ -d playground/current ]]; then
  bash "$REPOSITORY_ROOT/scripts/scenario.sh" clean
fi

git restore --source=HEAD --worktree -- playground
log "Playground restored; any active scenario was backed up and removed"
