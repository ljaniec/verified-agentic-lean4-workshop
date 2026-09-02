# Task 01.2 — Read the Invariant and Check the First Claims

**Target time:** 4 minutes

## Objective

Translate the informal resource policy into a precise state predicate, then use
Lean to discharge the two small proof obligations that anchor the exercise.

## Read

Compare the Python `safe` function with the Lean `Safe` predicate in the shared
scenario model.

The intended policy is:

```text
Active → sensorOpen ∧ logOpen
sensorOpen → Active
logOpen → Active
actuatorEnabled → Active
Unconfigured ∨ Finalized → no runtime resources
```

## Think

For each state below, decide whether it should be safe before asking the code:

```text
Inactive, sensor closed, log closed, actuator disabled
Inactive, sensor open,   log open,   actuator disabled
Active,   sensor open,   log open,   actuator enabled
Active,   sensor closed, log open,   actuator disabled
```

## Lean checkpoint

Open:

```text
playground/current/Current.lean
```

Complete the first two TODOs:

```text
initial_safe
buggy_deactivate_breaks_safety
```

Both are concrete facts about explicit states, so unfold/simplify the relevant
definitions rather than starting a large case analysis.

Useful first attempts:

```lean
simp [Safe, initial]
simp [Safe, activeState, buggyStep]
```

Do not paste a candidate without checking what it proves.

## Why both directions matter

`Active → sensorOpen` says what an active node must own. `sensorOpen → Active`
says that no other lifecycle mode may retain that resource. They are different
requirements.

## Done when

- you can explain why `Inactive + sensorOpen` is rejected even with the actuator
  disabled;
- the `initial_safe` and concrete buggy-deactivation theorems compile in your
  active Lean file.

## Hint

These first two goals are intentionally computational. Save the exhaustive case
analysis for the general one-step preservation theorem later.
