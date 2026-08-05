#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
cd "$REPOSITORY_ROOT"

if [[ -d .github/workflows ]] && find .github/workflows -type f -print -quit | grep -q .; then
  find .github/workflows -type f -print >&2
  fail "GitHub Actions workflows are forbidden in this repository"
fi

log "No GitHub Actions workflows found"
