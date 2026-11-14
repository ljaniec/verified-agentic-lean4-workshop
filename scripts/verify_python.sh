#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command uv
cd "$REPOSITORY_ROOT"
uv run --locked ruff check .
uv run --locked mypy scripts/browser_workshop.py
uv run --locked pytest
log "Python verification passed"
