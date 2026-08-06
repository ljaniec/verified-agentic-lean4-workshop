#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

LEAN_ONLY=0
SKIP_MODELS=0

usage() {
  cat <<'USAGE'
Usage: scripts/setup.sh [--lean-only] [--skip-models]

Options:
  --lean-only    Install and build only the Lean/Lean Copilot environment.
  --skip-models  Do not download Lean Copilot model weights yet.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --lean-only)
      LEAN_ONLY=1
      ;;
    --skip-models)
      SKIP_MODELS=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      fail "unknown setup option: $1"
      ;;
  esac
  shift
done

cd "$REPOSITORY_ROOT"

DOCTOR_ARGS=()
if [[ "$LEAN_ONLY" -eq 1 ]]; then
  DOCTOR_ARGS+=(--lean-only)
fi
bash "$REPOSITORY_ROOT/scripts/workshop_doctor.sh" "${DOCTOR_ARGS[@]}"

require_command git
require_command lake

log "Initializing Git LFS for this checkout"
git lfs install --local >/dev/null

if [[ ! -f lake-manifest.json ]]; then
  log "Creating the initial pinned Lake manifest"
  lake update
else
  log "Using the committed Lake manifest"
fi

log "Downloading the Mathlib binary cache"
lake exe cache get

if [[ "$SKIP_MODELS" -eq 0 ]]; then
  log "Downloading Lean Copilot models"
  lake exe LeanCopilot/download
else
  log "Skipping Lean Copilot model download"
fi

log "Building the Lean project"
lake build

if [[ "$LEAN_ONLY" -eq 0 ]]; then
  require_command uv
  log "Creating the optional Google ADK environment"
  uv sync --extra agent --group dev
else
  log "Skipping the optional Google ADK environment"
fi

log "Setup completed"
printf '\nNext command: ./workshop check%s\n' "$([[ "$LEAN_ONLY" -eq 1 ]] && printf ' --lean-only' || true)"
