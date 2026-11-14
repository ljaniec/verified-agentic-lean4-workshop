#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command uv
cd "$REPOSITORY_ROOT"

uv run --locked --extra agent ruff check .
uv run --locked --extra agent mypy src
uv run --locked --extra agent pytest

log "Python verification passed"
