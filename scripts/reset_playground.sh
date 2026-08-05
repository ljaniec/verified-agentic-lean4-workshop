#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command git
cd "$REPOSITORY_ROOT"

git restore --source=HEAD --worktree -- playground
rm -rf -- playground/current
log "Playground restored and the current scenario removed"
