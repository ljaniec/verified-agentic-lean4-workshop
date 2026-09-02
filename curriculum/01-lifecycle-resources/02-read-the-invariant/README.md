# Task 01.2 — Read the Invariant

**Target time:** 3 minutes

## Objective

Translate the informal resource policy into a precise state predicate.

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

## Why both directions matter

`Active → sensorOpen` says what an active node must own. `sensorOpen → Active`
says that no other lifecycle mode may retain that resource. They are different
requirements.

## Done when

You can explain why `Inactive + sensorOpen` must be rejected even when the
actuator is disabled.

## Hint

Do not confuse a lifecycle-state invariant with a complete application-state
invariant.
