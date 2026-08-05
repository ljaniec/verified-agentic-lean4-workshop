#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
cd "$REPOSITORY_ROOT"

LEAN_ONLY=0
if [[ "${1:-}" == "--lean-only" ]]; then
  LEAN_ONLY=1
  shift
fi
if [[ $# -ne 0 ]]; then
  fail "usage: scripts/verify.sh [--lean-only]"
fi

"$REPOSITORY_ROOT/scripts/check_no_github_actions.sh"

bash -n "$REPOSITORY_ROOT/workshop"
for script in scripts/*.sh; do
  bash -n "$script"
done

"$REPOSITORY_ROOT/scripts/verify_lean.sh"
if [[ "$LEAN_ONLY" -eq 0 ]]; then
  "$REPOSITORY_ROOT/scripts/verify_python.sh"
fi

log "All requested local acceptance checks passed"
