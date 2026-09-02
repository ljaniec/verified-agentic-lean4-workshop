# Task 02.2 — Find the Counterexample

**Target time:** 5 minutes

## Objective

Falsify the claim that the handwritten replacement already preserves the
reference behavior.

## Inspect

Find the deliberately buggy FSM decision function. Compare the order in which
it tests observations with the reference Behavior Tree policy.

## Task

Construct the smallest observation that makes the two implementations disagree.
Use Python to confirm the mismatch.

A useful pattern is:

```python
obs = Observation(...)
assert buggy_fsm_decision(obs) != bt_decision(obs)
```

Do not brute-force first. Reason about which two conditions need to be true at
the same time for priority to matter.

## Why this matters

A refactor may pass many ordinary examples while still changing behavior on one
combination of events. The counterexample tells us exactly which implicit
requirement the rewrite violated.

## Done when

You have one concrete observation for which the reference tree and buggy FSM
return different decisions, and you can explain why.

## Hint

Look for a case where driving is possible but another branch should have higher
priority.
