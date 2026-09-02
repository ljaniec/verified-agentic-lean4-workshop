# Solution Note — Task 01.5

The reference proof uses explicit case analysis over the finite fields of the
state and event. The safety hypothesis eliminates inconsistent combinations.

```lean
theorem step_preserves_safety
    (state : State)
    (event : Event)
    (safe : Safe state) :
    Safe (step state event) := by
  rcases state with ⟨mode, sensorOpen, logOpen, actuatorEnabled⟩
  cases mode <;>
    cases sensorOpen <;>
    cases logOpen <;>
    cases actuatorEnabled <;>
    cases event <;>
    simp [Safe, step, initial, activeState] at safe ⊢
```

For the first workshop, this intentionally explicit proof is preferable to
hiding the entire argument behind stronger automation: participants can see
that the universal theorem reduces to finitely many symbolic cases.
