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

Implement only:

```text
fsm_decision
```

Keep the counterexample from Task 02.2. Do not change the Behavior Tree
reference to make the rewrite pass: `MISSION_TREE` is the specification for this
exercise.

## Check the finite observation space

The model contains three Boolean observations, so there are only eight possible
input combinations. The starter already checks the repaired FSM against the
reference for all of them.

Run:

```bash
python3 playground/current/current.py
```

A successful run should reach:

```text
exercise completed
```

## Engineering question

Why is exhaustive comparison practical here but insufficient as a general
strategy for a real Behavior Tree with state, asynchronous actions, blackboard
values, and unbounded traces?

## Done when

The repaired Python FSM returns the same observable decision as the reference
for all eight observations and the Python exercise completes successfully.

## Recovery without the answer

Write the reference priority order on paper before editing the function. Then
make the handwritten checks follow that same order. The fix is about priority,
not about adding a new action or weakening the comparison.
