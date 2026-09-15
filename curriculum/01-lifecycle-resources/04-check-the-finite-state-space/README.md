# Task 01.4 — Check the Finite State Space

**Target time:** 3 minutes

## Objective

Use exhaustive execution as a bridge between example-based testing and a formal
proof.

## Edit

Implement `preservation_holds()` in:

```text
playground/current/current.py
```

The state representation is deliberately finite:

- four lifecycle modes;
- three Boolean resource flags.

Enumerate all states, keep only states satisfying `safe`, apply every event, and
check that every resulting state remains safe.

## Question

What does this exhaustive Python check establish, and what does it still not
establish compared with the Lean theorem?

For this finite toy state representation it is strong executable evidence. The
Lean theorem still gives us a checked logical statement directly connected to
the formal model and becomes much more important once the state space is no
longer conveniently enumerable.

## Run

```bash
python3 playground/current/current.py
```

## Done when

`preservation_holds()` returns `True` for the repaired `step` implementation.

## Hint

The reference structure is a nested universal check:

```text
for every safe state
    for every event
        safe(step(state, event))
```
