# 90-Minute Workshop Plan

## Learning goal

Participants should leave with one operational idea: an AI model or executable
test may propose and explore, but a precise invariant or refinement theorem is
what protects a robotics refactor across every abstract state.

## Run of show

| Time | Activity |
|---:|---|
| 0-7 min | Motivation: a real fleet-state and Behavior Tree refactoring failure |
| 7-12 min | Trust boundary: model proposal, Python execution, Lean verification |
| 12-32 min | Exercise 1: lifecycle + sensor + disk + actuator |
| 32-67 min | Exercise 2: Behavior Tree to handwritten FSM refinement |
| 67-77 min | Demo: VDA 5050-inspired semantic trace monitor |
| 77-87 min | Demo: perception-planner uncertainty contract |
| 87-90 min | What scales next: traces, richer BT semantics, standards, uncertainty sets |

## Commands used live

```bash
./workshop scenario start lifecycle
./workshop scenario check

./workshop scenario start bt
./workshop scenario check

./workshop scenario solution vda
./workshop scenario check

./workshop scenario solution uncertainty
./workshop scenario check
```

The instructor may reveal a reference solution with `scenario solution`, but
should first let participants inspect the failing Python assertion or Lean goal.

## Scope discipline

The first workshop does not attempt full ROS 2 lifecycle semantics, complete
BehaviorTree.CPP execution, VDA 5050 certification, or continuous-space
collision checking. Every model names its simplifications explicitly so the
proof claim remains exact.
