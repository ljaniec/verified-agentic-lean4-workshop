#!/usr/bin/env bash
set -Eeuo pipefail

REPOSITORY_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

log() {
  printf '[workshop] %s\n' "$*"
}

fail() {
  printf '[workshop] error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "missing command: $1"
}
