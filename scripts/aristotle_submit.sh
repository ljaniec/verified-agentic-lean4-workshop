#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
cd "$REPOSITORY_ROOT"

require_command uvx

if [[ -z "${ARISTOTLE_API_KEY:-}" ]]; then
  fail "ARISTOTLE_API_KEY is not set"
fi

prompt="${*:-Work on the Lean proof obligations in this project. Preserve the existing theorem statements, use no sorry or added axioms, and report every changed file.}"
version="${ARISTOTLELIB_VERSION:-2.1.0}"

log "Submitting the standard Lake project with Aristotle CLI ${version}"
log "Pinned project toolchain: $(tr -d '\n' < lean-toolchain)"

exec uvx --from "aristotlelib==${version}" aristotle submit \
  "$prompt" \
  --project-dir "$REPOSITORY_ROOT" \
  --wait
