# Task 01.6 — Lift Safety to Finite Traces

**Target time:** 2–4 minutes  
**Mode:** stretch task

## Objective

Turn one-step preservation into a statement about every finite sequence of
lifecycle events.

## Goal

Use the shared `run` function and prove the trace-level property:

```text
Safe state → Safe (run state events)
```

for an arbitrary list of events.

## Key idea

Induct on the event list:

```text
[]
    → nothing changes

event :: rest
    → one safe step
    → apply the induction hypothesis to the rest
```

This is the first example in the workshop where a local invariant becomes a
whole-execution guarantee.

## Useful Lean ideas

```lean
induction events generalizing state
simp [run]
```

Use your one-step preservation theorem in the inductive case.

## Done when

The trace theorem compiles, or you can explain the induction argument verbally.

## Timebox

Do not let this stretch task delay the Behavior Tree exercise. The main concept
is the induction structure, not proof golfing.
