# Task 02.2 — Find and Prove the Counterexample

**Target time:** 6 minutes

## Objective

Falsify the claim that the handwritten replacement already preserves the
reference behavior, first by execution and then by a small checked Lean fact.

## Inspect

Find the deliberately buggy FSM decision function. Compare the order in which
it tests observations with the reference Behavior Tree policy.

## Python task

Construct a small observation that makes the two implementations disagree. Use
Python to confirm the mismatch.

```python
obs = Observation(...)
assert buggy_fsm_decision(obs) != bt_decision(obs)
```

Do not brute-force first. Reason about which two conditions need to be true at
the same time for priority to matter.

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
used by this theorem. This is a fully decidable proposition, so try a direct
computational proof before doing case analysis.

A useful candidate is:

```lean
by decide
```

Compile/check the declaration; do not treat the suggestion itself as the
certificate.

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

- you have one concrete Python observation where the policies disagree;
- the Lean editor reports no remaining goal/error for
  `buggy_refactoring_counterexample`;
- you can explain why the mismatch occurs.

## Recovery without the answer

Look for a case where driving is possible but another branch should have higher
priority. If the Lean proof is the only blocker, remember that this theorem is
about one fully concrete decidable proposition; do not start the general Boolean
case split yet.
