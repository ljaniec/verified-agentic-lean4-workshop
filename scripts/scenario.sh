#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

CURRENT_DIR="$REPOSITORY_ROOT/playground/current"

usage() {
  cat <<'USAGE'
Usage: ./workshop scenario <command> [name]

Commands:
  list                     List available scenarios.
  start <name>             Load the unsolved Lean and Python starters.
  solution <name>          Load the reference Lean and Python solutions.
  check                    Compile and run the currently loaded pair.
  clean                    Remove the currently loaded pair.

Scenario names:
  lifecycle                ROS 2 lifecycle + sensor + log + actuator
  bt                       Behavior Tree to handwritten FSM refinement
  vda                      VDA 5050-inspired semantic trace monitor
  uncertainty              Perception-planner uncertainty contract
USAGE
}

scenario_files() {
  case "$1" in
    lifecycle)
      LEAN_STEM="01_LifecycleResources"
      PYTHON_STEM="01_lifecycle_resources"
      SOLUTION_LEAN="LifecycleResources"
      SOLUTION_PYTHON="lifecycle_resources"
      ;;
    bt)
      LEAN_STEM="02_BehaviorTreeRefinement"
      PYTHON_STEM="02_behavior_tree_refinement"
      SOLUTION_LEAN="BehaviorTreeRefinement"
      SOLUTION_PYTHON="behavior_tree_refinement"
      ;;
    vda)
      LEAN_STEM="03_VDA5050Trace"
      PYTHON_STEM="03_vda5050_trace"
      SOLUTION_LEAN="VDA5050Trace"
      SOLUTION_PYTHON="vda5050_trace"
      ;;
    uncertainty)
      LEAN_STEM="04_PerceptionPlannerContract"
      PYTHON_STEM="04_perception_planner_contract"
      SOLUTION_LEAN="PerceptionPlannerContract"
      SOLUTION_PYTHON="perception_planner_contract"
      ;;
    *)
      fail "unknown scenario '$1'; run './workshop scenario list'"
      ;;
  esac
}

load_start() {
  local scenario="$1"
  scenario_files "$scenario"
  mkdir -p "$CURRENT_DIR"
  cp "$REPOSITORY_ROOT/exercises/lean/$LEAN_STEM.lean.template" \
    "$CURRENT_DIR/Current.lean"
  cp "$REPOSITORY_ROOT/exercises/python/$PYTHON_STEM.py.template" \
    "$CURRENT_DIR/current.py"
  printf '%s\n' "$scenario" > "$CURRENT_DIR/scenario"
  log "Loaded unsolved '$scenario' scenario into playground/current"
}

load_solution() {
  local scenario="$1"
  scenario_files "$scenario"
  mkdir -p "$CURRENT_DIR"
  cp "$REPOSITORY_ROOT/VerifiedAgenticWorkshop/Solutions/$SOLUTION_LEAN.lean" \
    "$CURRENT_DIR/Current.lean"
  cp "$REPOSITORY_ROOT/solutions/python/$SOLUTION_PYTHON.py" \
    "$CURRENT_DIR/current.py"
  printf '%s\n' "$scenario" > "$CURRENT_DIR/scenario"
  log "Loaded reference solution for '$scenario'"
}

check_current() {
  require_command lake
  require_command python3
  [[ -f "$CURRENT_DIR/Current.lean" ]] || \
    fail "no scenario loaded; run './workshop scenario start <name>'"
  [[ -f "$CURRENT_DIR/current.py" ]] || \
    fail "current Python exercise is missing"

  cd "$REPOSITORY_ROOT"
  log "Checking current Lean exercise"
  lake env lean "$CURRENT_DIR/Current.lean"
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
  solution)
    [[ $# -eq 1 ]] || fail "usage: ./workshop scenario solution <name>"
    load_solution "$1"
    ;;
  check)
    [[ $# -eq 0 ]] || fail "usage: ./workshop scenario check"
    check_current
    ;;
  clean)
    [[ $# -eq 0 ]] || fail "usage: ./workshop scenario clean"
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
