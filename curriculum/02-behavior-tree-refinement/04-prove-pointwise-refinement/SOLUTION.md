# Solution Note — Task 02.4

```lean
theorem corrected_fsm_matches_bt (observation : Observation) :
    fsmDecision observation = btDecision observation := by
  rcases observation with ⟨cancelRequested, goalReached, pathAvailable⟩
  cases cancelRequested <;>
    cases goalReached <;>
    cases pathAvailable <;>
    rfl
```

The arbitrary `Observation` makes this a universal theorem over the formal
teaching model rather than a list of example assertions.
