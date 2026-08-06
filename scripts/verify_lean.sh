#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command lake
cd "$REPOSITORY_ROOT"

bash "$REPOSITORY_ROOT/scripts/check_forbidden_constructs.sh"
lake build

for file in playground/*.lean; do
  log "Checking $file"
  lake env lean -DwarningAsError=true "$file"
done

log "Lean verification passed"
