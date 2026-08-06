#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
cd "$REPOSITORY_ROOT"

# Require token-like whitespace boundaries for common proof holes so prose such
# as `sorry` in an explanatory comment does not trigger the scanner. The
# implemented_by attribute is rare enough to reject by name anywhere.
pattern='(^|[[:space:]])(sorry|admit|axiom|native_decide)([[:space:]]|$)|implemented_by'

if [[ $# -gt 0 ]]; then
  lean_files=("$@")
else
  mapfile -t lean_files < <(
    {
      find VerifiedAgenticWorkshop -type f -name '*.lean' -print 2>/dev/null
      find playground -maxdepth 1 -type f -name '*.lean' -print 2>/dev/null
    } | sort
  )
fi

if [[ "${#lean_files[@]}" -eq 0 ]]; then
  fail "no Lean files found for the proof-bypass scan"
fi

for lean_file in "${lean_files[@]}"; do
  [[ -f "$lean_file" ]] || fail "missing Lean file: $lean_file"
done

if grep -En "$pattern" "${lean_files[@]}"; then
  fail "forbidden Lean proof bypass detected"
fi

log "No forbidden Lean proof bypasses found"
