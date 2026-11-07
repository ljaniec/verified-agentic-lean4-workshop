#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
cd "$REPOSITORY_ROOT"

require_command git
require_command lake
require_command python3

[[ -f lean-toolchain ]] || fail "lean-toolchain is missing"
[[ -d .lake/packages/mathlib ]] || fail "dependencies are not prepared; run ./workshop prepare before the event"

bash "$REPOSITORY_ROOT/scripts/check_no_github_actions.sh"
bash -n "$REPOSITORY_ROOT/workshop"
for script in scripts/*.sh; do
  bash -n "$script"
done

lake env lean --version >/dev/null
python3 -c 'import sys; assert sys.version_info >= (3, 11)' >/dev/null

log "Fast workshop preflight passed"
