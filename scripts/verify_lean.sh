#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command lake
cd "$REPOSITORY_ROOT"

bash "$REPOSITORY_ROOT/scripts/check_forbidden_constructs.sh"
python3 "$REPOSITORY_ROOT/scripts/browser_workshop.py" check
lake build

# `playground/` is now a runtime workspace. If a facilitator intentionally
# commits a standalone checked example there in the future, validate it; an
# empty set must not expand to the literal `playground/*.lean` path.
shopt -s nullglob
for file in playground/*.lean; do
  log "Checking $file"
  lake env lean -DwarningAsError=true "$file"
done
shopt -u nullglob

log "Lean verification passed"
