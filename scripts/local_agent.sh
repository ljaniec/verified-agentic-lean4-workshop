#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

TINY_MODEL="ggml-org/Qwen3.5-0.8B-GGUF:Q4_0"
STANDARD_MODEL="Qwen/Qwen3-4B-GGUF:Q4_K_M"
PORT="${LOCAL_AGENT_PORT:-8080}"

usage() {
  cat <<'USAGE'
Usage: ./workshop local-agent <command> [profile]

Commands:
  profiles          Show recommended laptop profiles.
  doctor            Check llama.cpp availability.
  serve tiny        Run the ~0.8B low-memory profile.
  serve standard    Run the ~4B standard-laptop profile.
  prompt            Print the current task prompt for any local client.

The server is OpenAI-compatible at http://127.0.0.1:8080/v1 by default.
USAGE
}

profiles() {
  cat <<EOF
tiny
  model:    $TINY_MODEL
  purpose:  task navigation, explanation, small edits
  target:   CPU-only or very small laptop GPU
  model file is roughly 0.6 GB; runtime memory is higher

standard
  model:    $STANDARD_MODEL
  purpose:  stronger coding/reasoning suggestions
  target:   ordinary laptop with several GB of free RAM; GPU offload optional
  Q4_K_M model file is roughly 2.5 GB; runtime memory is higher

Lean remains the verifier in both profiles.
EOF
}

doctor() {
  if command -v llama >/dev/null 2>&1; then
    printf 'OK   llama       %s\n' "$(command -v llama)"
  elif command -v llama-server >/dev/null 2>&1; then
    printf 'OK   llama-server %s\n' "$(command -v llama-server)"
  else
    fail "llama.cpp is not installed; see docs/local-agent-recipe.md"
  fi
}

model_for_profile() {
  case "$1" in
    tiny) printf '%s' "$TINY_MODEL" ;;
    standard) printf '%s' "$STANDARD_MODEL" ;;
    *) fail "unknown local-agent profile '$1'" ;;
  esac
}

serve() {
  local profile="${1:-tiny}" model
  model="$(model_for_profile "$profile")"

  doctor
  if command -v llama >/dev/null 2>&1; then
    exec llama serve -hf "$model" --host 127.0.0.1 --port "$PORT"
  else
    exec llama-server -hf "$model" --host 127.0.0.1 --port "$PORT"
  fi
}

prefetch() {
  local profile="${1:-tiny}" model
  model="$(model_for_profile "$profile")"
  doctor
  log "Prefetching local model profile '$profile'"
  if command -v llama >/dev/null 2>&1; then
    llama cli -hf "$model" -p "Reply only READY" -n 1 >/dev/null
  elif command -v llama-cli >/dev/null 2>&1; then
    llama-cli -hf "$model" -p "Reply only READY" -n 1 >/dev/null
  else
    fail "llama CLI is unavailable even though a server binary was found"
  fi
  log "Local model '$profile' is cached"
}

case "${1:-profiles}" in
  profiles) profiles ;;
  doctor) doctor ;;
  serve) shift; serve "${1:-tiny}" ;;
  prefetch) shift; prefetch "${1:-tiny}" ;;
  prompt)
    exec bash "$REPOSITORY_ROOT/scripts/task.sh" prompt
    ;;
  help|-h|--help) usage ;;
  *) usage >&2; fail "unknown local-agent command '$1'" ;;
esac
