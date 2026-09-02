# Task 02.3 — Repair the FSM

**Target time:** 6 minutes

## Objective

Change the handwritten implementation so its observable decision priority
matches the reference tree.

## Edit

Open:

```text
playground/current/current.py
```

Implement or repair the participant FSM function.

## Constraint

Do not change the Behavior Tree reference to match the rewrite. The reference
policy is the specification for this exercise.

## Check the finite observation space

The model contains three Boolean observations, so there are only eight possible
input combinations. After repairing the FSM, compare it against the reference
for every observation.

Use the helper already provided by the starter where possible.

## Engineering question

Why is exhaustive comparison practical here but insufficient as a general
strategy for a real Behavior Tree with state, asynchronous actions, blackboard
values, and unbounded traces?

## Done when

The repaired Python FSM returns the same observable decision as the reference
for all eight observations.

## Hint

The fix is about **priority**, not about adding a new action.
