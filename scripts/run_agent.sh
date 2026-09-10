#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command uv
cd "$REPOSITORY_ROOT"

if [[ ! -f .env ]]; then
  fail "copy .env.example to .env and configure the tested Gemini demo first"
fi
if ! grep -Eq '^GOOGLE_API_KEY=.+$' .env; then
  fail "GOOGLE_API_KEY is not configured in .env"
fi
if ! grep -Eq '^GOOGLE_MODEL=.+$' .env; then
  fail "GOOGLE_MODEL is not configured in .env; set the tested event model"
fi

exec uv run adk run agents/verified_lean_tutor
