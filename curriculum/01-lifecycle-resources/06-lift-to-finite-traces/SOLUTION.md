# Solution Note — Task 01.6

The reference proof is induction over the event list, generalizing the current
state so the induction hypothesis can be applied after one transition:

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

The conceptual dependency is the important part:

```text
one-step preservation + induction = finite-trace preservation
```
