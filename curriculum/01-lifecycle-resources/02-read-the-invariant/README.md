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

### Important: this is an intermediate checkpoint

The later `step_preserves_safety` TODO is still intentionally unfinished, so the
whole file is not expected to pass `./workshop scenario check` yet. Use the Lean
editor to verify that each theorem you just edited has no remaining goal/error
at that declaration. The full scenario check comes after Task 01.5.

## Why both directions matter

`Active → sensorOpen` says what an active node must own. `sensorOpen → Active`
says that no other lifecycle mode may retain that resource. They are different
requirements.

## Done when

- you can explain why `Inactive + sensorOpen` is rejected even with the actuator
  disabled;
- the Lean editor reports no remaining goal/error for `initial_safe` and
  `buggy_deactivate_breaks_safety`.

## Recovery without the answer

If one of the two concrete goals remains open, unfold only the definitions named
in that theorem and simplify. Do not start the large state/event case split yet;
that belongs to Task 01.5. If the room moves on, leave the later TODOs alone and
continue with the Python repair.
