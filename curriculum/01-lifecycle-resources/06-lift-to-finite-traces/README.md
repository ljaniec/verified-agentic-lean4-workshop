# Task 01.6 — Lift Safety to Finite Traces

**Target time:** 2–4 minutes  
**Mode:** stretch task

## Objective

Turn one-step preservation into a statement about every finite sequence of
lifecycle events without making this optional theorem block the main workshop
path.

## Before you start

The baseline starter intentionally does **not** predeclare this theorem. Tasks
01.1–01.5 can therefore finish with a clean `./workshop scenario check` even if
you skip this stretch task.

Only continue here when the baseline lifecycle scenario already passes.

## Add this theorem

Insert the following declaration before the final namespace `end` in
`playground/current/Current.lean`:

```lean
theorem run_preserves_safety
    (state : State)
    (events : List Event)
    (safe : Safe state) :
    Safe (run state events) := by
  -- prove the stretch theorem here
```

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

Use your `step_preserves_safety` theorem in the inductive case.

## Check

If you choose to add the theorem, run:

```bash
./workshop scenario check
```

## Done when

Either the added trace theorem compiles, or you can explain the induction
argument verbally and move on.

## Recovery / falling behind

Do not let this stretch task delay the Behavior Tree exercise. If your added
optional theorem is unfinished when the facilitator moves on, keep a copy in
your editor or backup, remove the incomplete addition from the baseline file if
you still want a clean lifecycle check, and start the next scenario. The loader
backs up the current pair automatically.
