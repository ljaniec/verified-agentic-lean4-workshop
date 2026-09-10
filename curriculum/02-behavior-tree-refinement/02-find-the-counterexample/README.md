# Task 02.2 — Find and Prove the Counterexample

**Target time:** 6 minutes

## Objective

Falsify the claim that the handwritten replacement already preserves the
reference behavior, first by execution and then by a small checked Lean fact.

## Inspect

Find `buggy_fsm_decision` and compare the order in which it tests observations
with the branch order in `MISSION_TREE`.

## Python task

Open:

```text
playground/current/current.py
```

Implement only:

```text
counterexample_observation
```

Return a small observation that makes the buggy handwritten FSM disagree with
the reference Behavior Tree. Do not repair `fsm_decision` yet.

Reason about which two conditions need to be true at the same time for priority
to matter. You can inspect your candidate interactively, but the complete Python
file is still expected to stop later at the unfinished `fsm_decision` TODO.

## Lean checkpoint

Open:

```text
playground/current/Current.lean
```

Complete:

```text
buggy_refactoring_counterexample
```

The shared scenario defines the concrete `cancelWhilePathAvailable` observation
used by this theorem. Compare it with the Python counterexample you found. The
Lean goal is a fully decidable proposition, so try a direct computational proof
before doing case analysis.

A useful candidate is:

```lean
by decide
```

Check the declaration; do not treat the suggestion itself as the certificate.

### Important: this is an intermediate checkpoint

`corrected_fsm_matches_bt` is still intentionally unfinished. The whole Lean
file is therefore not expected to pass `./workshop scenario check` yet. Confirm
in the Lean editor that the concrete counterexample theorem itself has no
remaining goal/error. The full scenario check comes after Task 02.4.

## Why this matters

A refactor may pass many ordinary examples while still changing behavior on one
combination of events. The counterexample identifies the implicit priority rule
that the rewrite violated.

## Done when

- `counterexample_observation()` returns a case where the two policies disagree;
- the Lean editor reports no remaining goal/error for
  `buggy_refactoring_counterexample`;
- you can explain why the mismatch occurs.

## Recovery without the answer

Look for a case where driving is possible but another branch should have higher
priority. If the Lean proof is the only blocker, remember that this theorem is
about one fully concrete decidable proposition; do not start the general Boolean
case split yet.
