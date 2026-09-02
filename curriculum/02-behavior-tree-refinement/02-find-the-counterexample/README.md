# Task 02.2 — Find and Prove the Counterexample

**Target time:** 6 minutes

## Objective

Falsify the claim that the handwritten replacement already preserves the
reference behavior, first by execution and then by a small checked Lean fact.

## Inspect

Find the deliberately buggy FSM decision function. Compare the order in which
it tests observations with the reference Behavior Tree policy.

## Python task

Construct the smallest observation that makes the two implementations disagree.
Use Python to confirm the mismatch.

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

The shared scenario already defines the concrete `cancelWhilePathAvailable`
observation. This is a fully decidable concrete proposition, so try a direct
computational proof before doing case analysis.

A useful candidate is:

```lean
by decide
```

Compile it; do not treat the suggestion itself as the certificate.

## Why this matters

A refactor may pass many ordinary examples while still change behavior on one
combination of events. The counterexample identifies the implicit priority rule
that the rewrite violated.

## Done when

- you have one concrete Python observation where the policies disagree;
- the corresponding concrete Lean counterexample theorem compiles;
- you can explain why the mismatch occurs.

## Hint

Look for a case where driving is possible but another branch should have higher
priority.
