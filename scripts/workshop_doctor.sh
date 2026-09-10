#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

LEAN_ONLY=0
if [[ "${1:-}" == "--lean-only" ]]; then
  LEAN_ONLY=1
  shift
fi
if [[ $# -ne 0 ]]; then
  fail "usage: scripts/workshop_doctor.sh [--lean-only]"
fi

cd "$REPOSITORY_ROOT"
status=0

check_command() {
  local command_name="$1"
  local installation_hint="$2"
  if command -v "$command_name" >/dev/null 2>&1; then
    printf 'OK   %-12s %s\n' "$command_name" "$(command -v "$command_name")"
  else
    printf 'FAIL %-12s missing\n' "$command_name"
    printf '     install: %s\n' "$installation_hint"
    status=1
  fi
}

printf 'Core Lean environment\n'
check_command git 'https://git-scm.com/downloads'
check_command git-lfs 'https://git-lfs.com/'
check_command elan 'https://lean-lang.org/lean4/doc/quickstart.html'
check_command lake 'installed automatically by elan with the pinned Lean toolchain'

if [[ "$LEAN_ONLY" -eq 0 ]]; then
  printf '\nOptional Google ADK environment\n'
  check_command python3 'Python 3.11 or 3.12 from https://www.python.org/downloads/'
  check_command uv 'https://docs.astral.sh/uv/getting-started/installation/'
fi

printf '\nProject state\n'
if [[ -f lean-toolchain ]]; then
  printf 'OK   %-12s %s\n' 'toolchain' "$(tr -d '\n' < lean-toolchain)"
else
  printf 'FAIL %-12s missing lean-toolchain\n' 'toolchain'
  status=1
fi

if [[ -f lake-manifest.json ]]; then
  printf 'OK   %-12s committed dependency lock\n' 'Lake lock'
else
  printf 'INFO %-12s will be created by the first setup run\n' 'Lake lock'
fi

if [[ -d .lake/packages/LeanCopilot ]]; then
  printf 'OK   %-12s dependency present\n' 'LeanCopilot'
else
  printf 'INFO %-12s run ./workshop setup\n' 'LeanCopilot'
fi

if [[ "$LEAN_ONLY" -eq 0 ]]; then
  printf '\nOptional Gemini configuration\n'
  gemini_key=0
  gemini_model=0

  if [[ -f .env ]] && grep -Eq '^GOOGLE_API_KEY=.+$' .env; then
    gemini_key=1
    printf 'OK   %-12s configured\n' 'Gemini key'
  else
    printf 'INFO %-12s optional; configure only for the tested agent demo\n' 'Gemini key'
  fi

  if [[ -f .env ]] && grep -Eq '^GOOGLE_MODEL=.+$' .env; then
    gemini_model=1
    printf 'OK   %-12s configured\n' 'Gemini model'
  else
    printf 'INFO %-12s no tested event model selected yet\n' 'Gemini model'
  fi

  if [[ "$gemini_key" -ne "$gemini_model" ]]; then
    printf 'WARN %-12s key and model should be configured together\n' 'Gemini config'
  fi
fi

if [[ "$status" -eq 0 ]]; then
  printf '\nEnvironment prerequisites are available.\n'
else
  printf '\nInstall the missing prerequisites, then rerun ./workshop doctor.\n' >&2
fi

exit "$status"
