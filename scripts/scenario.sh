#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

CURRENT_DIR="$REPOSITORY_ROOT/playground/current"
BACKUP_ROOT="$REPOSITORY_ROOT/playground/backups"

usage() {
  cat <<'USAGE'
Usage: ./workshop scenario <command> [name]

Commands:
  list                     List available scenarios.
  start <name>             Load an unsolved Lean and Python starter.
  status                   Show the currently loaded scenario.
  check                    Compile and run the currently loaded pair.
  clean                    Back up and remove the currently loaded pair.

Scenario names:
  lifecycle                ROS 2 lifecycle + sensor + log + actuator
  bt                       Behavior Tree to handwritten FSM refinement
  vda                      VDA 5050-inspired semantic trace monitor
  uncertainty              Perception-planner uncertainty contract

Reference solutions are intentionally absent from the participant branch.
USAGE
}

scenario_files() {
  case "$1" in
    lifecycle)
      LEAN_STEM="01_LifecycleResources"
      PYTHON_STEM="01_lifecycle_resources"
      ;;
    bt)
      LEAN_STEM="02_BehaviorTreeRefinement"
      PYTHON_STEM="02_behavior_tree_refinement"
      ;;
    vda)
      LEAN_STEM="03_VDA5050Trace"
      PYTHON_STEM="03_vda5050_trace"
      ;;
    uncertainty)
      LEAN_STEM="04_PerceptionPlannerContract"
      PYTHON_STEM="04_perception_planner_contract"
      ;;
    agent)
      LEAN_STEM="05_AgentRepair"
      PYTHON_STEM="05_agent_repair"
      ;;
    *)
      fail "unknown scenario '$1'; run './workshop scenario list'"
      ;;
  esac
}

safe_metadata_value() {
  local kind="$1"
  local value="$2"

  case "$kind:$value" in
    scenario:lifecycle|scenario:bt|scenario:vda|scenario:uncertainty|scenario:agent)
      printf '%s' "$value"
      ;;
    source:starter)
      printf '%s' "$value"
      ;;
    *)
      printf 'unknown'
      ;;
  esac
}

backup_current() {
  if [[ ! -f "$CURRENT_DIR/Current.lean" && ! -f "$CURRENT_DIR/current.py" ]]; then
    return
  fi

  local raw_scenario raw_source scenario source timestamp backup_dir
  raw_scenario="$(cat "$CURRENT_DIR/scenario" 2>/dev/null || printf 'unknown')"
  raw_source="$(cat "$CURRENT_DIR/source" 2>/dev/null || printf 'unknown')"
  scenario="$(safe_metadata_value scenario "$raw_scenario")"
  source="$(safe_metadata_value source "$raw_source")"
  timestamp="$(date -u '+%Y%m%dT%H%M%SZ')"
  backup_dir="$BACKUP_ROOT/${timestamp}-${scenario}-${source}-$$"
  mkdir -p "$backup_dir"

  for filename in Current.lean current.py scenario source; do
    if [[ -f "$CURRENT_DIR/$filename" ]]; then
      cp "$CURRENT_DIR/$filename" "$backup_dir/$filename"
    fi
  done

  log "Backed up the current work to ${backup_dir#$REPOSITORY_ROOT/}"
}

write_metadata() {
  local scenario="$1"
  printf '%s\n' "$scenario" > "$CURRENT_DIR/scenario"
  printf 'starter\n' > "$CURRENT_DIR/source"
}

load_start() {
  local scenario="$1"
  scenario_files "$scenario"
  backup_current
  mkdir -p "$CURRENT_DIR"
  cp "$REPOSITORY_ROOT/exercises/lean/$LEAN_STEM.lean.template" \
    "$CURRENT_DIR/Current.lean"
  cp "$REPOSITORY_ROOT/exercises/python/$PYTHON_STEM.py.template" \
    "$CURRENT_DIR/current.py"
  write_metadata "$scenario"
  log "Loaded unsolved '$scenario' scenario into playground/current"
}

show_status() {
  if [[ ! -f "$CURRENT_DIR/scenario" ]]; then
    printf 'No scenario is currently loaded.\n'
    return
  fi

  printf 'Scenario: %s\n' "$(cat "$CURRENT_DIR/scenario")"
  printf 'Source:   starter\n'
  printf 'Lean:     %s\n' "${CURRENT_DIR#$REPOSITORY_ROOT/}/Current.lean"
  printf 'Python:   %s\n' "${CURRENT_DIR#$REPOSITORY_ROOT/}/current.py"
}

check_current() {
  require_command lake
  require_command python3
  [[ -f "$CURRENT_DIR/Current.lean" ]] || \
    fail "no scenario loaded; run './workshop scenario start <name>'"
  [[ -f "$CURRENT_DIR/current.py" ]] || \
    fail "current Python exercise is missing"

  cd "$REPOSITORY_ROOT"
  log "Scanning the current Lean exercise for proof bypasses"
  bash "$REPOSITORY_ROOT/scripts/check_forbidden_constructs.sh" \
    "$CURRENT_DIR/Current.lean"
  log "Checking current Lean exercise"
  lake env lean -DwarningAsError=true "$CURRENT_DIR/Current.lean"
  log "Checking current Python syntax"
  python3 -m py_compile "$CURRENT_DIR/current.py"
  log "Running current Python exercise"
  python3 "$CURRENT_DIR/current.py"
  log "Current scenario passed both checks"
}

command_name="${1:-list}"
if [[ $# -gt 0 ]]; then
  shift
fi

case "$command_name" in
  list)
    usage
    ;;
  start)
    [[ $# -eq 1 ]] || fail "usage: ./workshop scenario start <name>"
    load_start "$1"
    ;;
  status)
    [[ $# -eq 0 ]] || fail "usage: ./workshop scenario status"
    show_status
    ;;
  check)
    [[ $# -eq 0 ]] || fail "usage: ./workshop scenario check"
    check_current
    ;;
  clean)
    [[ $# -eq 0 ]] || fail "usage: ./workshop scenario clean"
    backup_current
    rm -rf -- "$CURRENT_DIR"
    log "Removed playground/current"
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    usage >&2
    fail "unknown scenario command '$command_name'"
    ;;
esac
