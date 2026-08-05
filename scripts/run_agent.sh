#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command uv
cd "$REPOSITORY_ROOT"

if [[ ! -f .env ]]; then
  fail "copy .env.example to .env and set GOOGLE_API_KEY first"
fi

exec uv run adk run agents/verified_lean_tutor
