# Solution Note — Task 01.6

Induct over the event list while generalizing the current state:

```lean
theorem run_preserves_safety
    (state : State)
    (events : List Event)
    (safe : Safe state) :
    Safe (run state events) := by
  induction events generalizing state with
  | nil =>
      simpa [run]
  | cons event rest inductionHypothesis =>
      simp only [run]
      exact inductionHypothesis
        (step state event)
        (step_preserves_safety state event safe)
```

The conceptual dependency is the main lesson:

```text
one-step preservation + induction = finite-trace preservation
```
