#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

WITH_COPILOT=0
LOCAL_PROFILE=""

usage() {
  cat <<'USAGE'
Usage: ./workshop prepare [--with-lean-copilot] [--local-agent tiny|standard]

Default preparation:
  - installs/resolves Lean + Mathlib + Python/ADK dependencies;
  - skips optional Lean Copilot model weights;
  - runs the complete local acceptance suite.

Options:
  --with-lean-copilot        Also download Lean Copilot model weights.
  --local-agent PROFILE      Prefetch a llama.cpp model for the local path.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-lean-copilot) WITH_COPILOT=1 ;;
    --local-agent)
      shift
      LOCAL_PROFILE="${1:-}"
      [[ "$LOCAL_PROFILE" == "tiny" || "$LOCAL_PROFILE" == "standard" ]] ||
        fail "--local-agent expects tiny or standard"
      ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; fail "unknown prepare option '$1'" ;;
  esac
  shift
done

SETUP_ARGS=()
if [[ "$WITH_COPILOT" -eq 0 ]]; then
  SETUP_ARGS+=(--skip-models)
fi

bash "$REPOSITORY_ROOT/scripts/setup.sh" "${SETUP_ARGS[@]}"
bash "$REPOSITORY_ROOT/scripts/verify.sh"

if [[ -n "$LOCAL_PROFILE" ]]; then
  bash "$REPOSITORY_ROOT/scripts/local_agent.sh" prefetch "$LOCAL_PROFILE"
fi

log "Pre-event preparation completed"
printf '\nAt the event run:\n  git switch workshop/00-build\n  ./workshop task start\n'
