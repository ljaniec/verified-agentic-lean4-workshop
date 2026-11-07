#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

TASK_TABLE="$REPOSITORY_ROOT/course/45min/tasks.tsv"

usage() {
  cat <<'USAGE'
Usage: ./workshop task <command> [options]

Commands:
  list                 Show all 45-minute checkpoint branches.
  status               Show the current branch/task metadata.
  start                Prepare the current task and print WORKSHOP_TASK.md.
  check                Run the verification gate for the current task.
  prompt               Print a one-line prompt for Codex/Claude/Gemini.
  next                 Back up active work, switch to the next task branch, start it.
  solution [--checkout]  Show the matching solution branch; optionally switch to it.
USAGE
}

current_branch() {
  git -C "$REPOSITORY_ROOT" branch --show-current
}

lookup_row() {
  local branch_name="$1"
  awk -F '|' -v b="$branch_name" '
    $1 !~ /^#/ && ($3 == b || $4 == b) { print; exit }
  ' "$TASK_TABLE"
}

load_task() {
  local branch_name row
  branch_name="$(current_branch)"
  row="$(lookup_row "$branch_name")"
  [[ -n "$row" ]] || fail "branch '$branch_name' is not a 45-minute task branch"

  IFS='|' read -r TASK_ID SCENARIO TASK_BRANCH SOLUTION_BRANCH NEXT_BRANCH MINUTES TITLE <<<"$row"
  CURRENT_BRANCH="$branch_name"
  if [[ "$CURRENT_BRANCH" == "$SOLUTION_BRANCH" ]]; then
    IS_SOLUTION=1
  else
    IS_SOLUTION=0
  fi
}

show_status() {
  load_task
  printf 'Task:       %s\n' "$TASK_ID"
  printf 'Title:      %s\n' "$TITLE"
  printf 'Branch:     %s\n' "$CURRENT_BRANCH"
  printf 'Timebox:    %s min\n' "$MINUTES"
  printf 'Scenario:   %s\n' "${SCENARIO:-none}"
  printf 'Solution:   %s\n' "$SOLUTION_BRANCH"
  printf 'Next:       %s\n' "${NEXT_BRANCH:-wrap-up}"
  if [[ "$IS_SOLUTION" -eq 1 ]]; then
    printf 'Mode:       solution checkpoint\n'
  else
    printf 'Mode:       participant task\n'
  fi
}

start_task() {
  load_task

  if [[ -n "$SCENARIO" ]]; then
    local active=""
    if [[ -f "$REPOSITORY_ROOT/playground/current/scenario" ]]; then
      active="$(cat "$REPOSITORY_ROOT/playground/current/scenario")"
    fi
    if [[ "$active" != "$SCENARIO" ]]; then
      bash "$REPOSITORY_ROOT/scripts/scenario.sh" start "$SCENARIO"
    fi
  fi

  printf '\n=== WORKSHOP TASK ===\n\n'
  if [[ -f "$REPOSITORY_ROOT/WORKSHOP_TASK.md" ]]; then
    cat "$REPOSITORY_ROOT/WORKSHOP_TASK.md"
  else
    printf 'No WORKSHOP_TASK.md exists on this branch.\n'
  fi
}

check_task() {
  load_task
  if [[ -n "$SCENARIO" ]]; then
    bash "$REPOSITORY_ROOT/scripts/scenario.sh" check
  else
    bash "$REPOSITORY_ROOT/scripts/quickcheck.sh"
  fi
  printf '\nWORKSHOP_TASK_OK %s\n' "$TASK_ID"
}

print_prompt() {
  load_task
  printf '%s\n' "Follow AGENTS.md and WORKSHOP_TASK.md. Complete task $TASK_ID ($TITLE). Run ./workshop task check after each meaningful edit. Stop when it prints WORKSHOP_TASK_OK. Do not inspect a solution branch unless I explicitly ask."
}

clean_active() {
  if [[ -d "$REPOSITORY_ROOT/playground/current" ]]; then
    bash "$REPOSITORY_ROOT/scripts/scenario.sh" clean
  fi
}

switch_branch() {
  local target="$1"
  clean_active
  git -C "$REPOSITORY_ROOT" switch "$target"
}

next_task() {
  load_task
  [[ -n "$NEXT_BRANCH" ]] || fail "this is the final task; continue to the wrap-up"
  switch_branch "$NEXT_BRANCH"
  exec bash "$REPOSITORY_ROOT/scripts/task.sh" start
}

show_solution() {
  load_task
  local checkout=0
  if [[ "${1:-}" == "--checkout" ]]; then
    checkout=1
    shift
  fi
  [[ $# -eq 0 ]] || fail "usage: ./workshop task solution [--checkout]"

  printf '%s\n' "$SOLUTION_BRANCH"
  if [[ "$checkout" -eq 1 ]]; then
    switch_branch "$SOLUTION_BRANCH"
    exec bash "$REPOSITORY_ROOT/scripts/task.sh" start
  fi
}

command_name="${1:-status}"
if [[ $# -gt 0 ]]; then shift; fi

case "$command_name" in
  list) column -t -s '|' "$TASK_TABLE" 2>/dev/null || cat "$TASK_TABLE" ;;
  status) [[ $# -eq 0 ]] || fail "usage: ./workshop task status"; show_status ;;
  start) [[ $# -eq 0 ]] || fail "usage: ./workshop task start"; start_task ;;
  check) [[ $# -eq 0 ]] || fail "usage: ./workshop task check"; check_task ;;
  prompt) [[ $# -eq 0 ]] || fail "usage: ./workshop task prompt"; print_prompt ;;
  next) [[ $# -eq 0 ]] || fail "usage: ./workshop task next"; next_task ;;
  solution) show_solution "$@" ;;
  help|-h|--help) usage ;;
  *) usage >&2; fail "unknown task command '$command_name'" ;;
esac
