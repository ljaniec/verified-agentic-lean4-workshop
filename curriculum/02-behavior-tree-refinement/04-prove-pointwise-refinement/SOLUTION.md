# Solution Note — Task 02.4

The reference proof destructs the observation and checks all Boolean cases:

```lean
theorem corrected_fsm_matches_bt (observation : Observation) :
    fsmDecision observation = btDecision observation := by
  rcases observation with ⟨cancelRequested, goalReached, pathAvailable⟩
  cases cancelRequested <;>
    cases goalReached <;>
    cases pathAvailable <;>
    rfl
```

The theorem is stronger than a list of example assertions because its argument
is an arbitrary `Observation` in the formal model.
