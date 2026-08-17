#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
cd "$REPOSITORY_ROOT"

# This is a conservative workshop guard, not a replacement for Lean's parser.
# It removes Lean line comments, nested block comments, and string literals
# before looking for proof holes or declarations that introduce unchecked
# assumptions. Identifier-style boundaries catch forms such as `(by sorry)`
# without rejecting prose such as "Do not use `sorry`" inside comments.
scan_file() {
  local lean_file="$1"

  awk '
    BEGIN { block_depth = 0; bad = 0 }
    {
      line = $0
      code = ""
      in_string = 0
      escaped = 0
      i = 1

      while (i <= length(line)) {
        c = substr(line, i, 1)
        nextc = (i < length(line)) ? substr(line, i + 1, 1) : ""

        if (block_depth > 0) {
          if (c == "/" && nextc == "-") {
            block_depth++
            i += 2
            continue
          }
          if (c == "-" && nextc == "/") {
            block_depth--
            i += 2
            continue
          }
          i++
          continue
        }

        if (in_string) {
          if (escaped) {
            escaped = 0
          } else if (c == "\\") {
            escaped = 1
          } else if (c == "\"") {
            in_string = 0
          }
          i++
          continue
        }

        if (c == "-" && nextc == "-") {
          break
        }
        if (c == "/" && nextc == "-") {
          block_depth++
          i += 2
          continue
        }
        if (c == "\"") {
          in_string = 1
          i++
          continue
        }

        code = code c
        i++
      }

      if (code ~ /(^|[^[:alnum:]_])(sorry|admit|axiom|constant|sorryAx|native_decide|implemented_by)([^[:alnum:]_]|$)/) {
        print FILENAME ":" FNR ":" $0
        bad = 1
      }
    }
    END { exit bad }
  ' "$lean_file"
}

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
  if ! scan_file "$lean_file"; then
    fail "forbidden Lean proof bypass detected"
  fi
done

log "No forbidden Lean proof bypasses found"
