#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
cd "$REPOSITORY_ROOT"

pattern='\b(sorry|admit|axiom|native_decide|implemented_by)\b'
mapfile -t lean_files < <(find VerifiedAgenticWorkshop playground -type f -name '*.lean' -print | sort)

if grep -En "$pattern" "${lean_files[@]}"; then
  fail "forbidden Lean proof bypass detected"
fi

log "No forbidden Lean proof bypasses found"
