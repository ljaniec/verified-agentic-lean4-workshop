#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

WITH_COPILOT=0
WITH_GOOGLE_ADK=0
LOCAL_PROFILE=""

usage() {
  cat <<'USAGE'
Usage: ./workshop prepare [options]

Default preparation is intentionally minimal:
  - Lean/Mathlib project dependencies and build;
  - Python 3 runtime check for executable examples;
  - no cloud credentials;
  - no Google ADK environment;
  - no Lean Copilot model weights.

Options:
  --with-lean-copilot        Download Lean Copilot model weights.
  --with-google-adk          Install the optional Google ADK/dev environment.
  --local-agent PROFILE      Prefetch llama.cpp profile: tiny or standard.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-lean-copilot) WITH_COPILOT=1 ;;
    --with-google-adk) WITH_GOOGLE_ADK=1 ;;
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

require_command python3

SETUP_ARGS=()
if [[ "$WITH_GOOGLE_ADK" -eq 0 ]]; then
  SETUP_ARGS+=(--lean-only)
fi
if [[ "$WITH_COPILOT" -eq 0 ]]; then
  SETUP_ARGS+=(--skip-models)
fi

bash "$REPOSITORY_ROOT/scripts/setup.sh" "${SETUP_ARGS[@]}"

if [[ "$WITH_GOOGLE_ADK" -eq 1 ]]; then
  bash "$REPOSITORY_ROOT/scripts/verify.sh"
else
  bash "$REPOSITORY_ROOT/scripts/verify.sh" --lean-only
fi

bash "$REPOSITORY_ROOT/scripts/quickcheck.sh"

if [[ -n "$LOCAL_PROFILE" ]]; then
  bash "$REPOSITORY_ROOT/scripts/local_agent.sh" prefetch "$LOCAL_PROFILE"
fi

log "Pre-event preparation completed"
printf '\nAt the event run:\n  git switch workshop/00-build\n  ./workshop task start\n'
