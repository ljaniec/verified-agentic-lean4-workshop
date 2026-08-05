#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
require_command uv
cd "$REPOSITORY_ROOT"

uv run ruff check .
uv run mypy src
uv run pytest

log "Python verification passed"
