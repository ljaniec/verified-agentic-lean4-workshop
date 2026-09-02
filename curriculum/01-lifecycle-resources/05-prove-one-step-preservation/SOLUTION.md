# Solution Note — Task 01.5

The reference proof uses direct symbolic case analysis over the finite fields of
the state and event. The safety hypothesis eliminates inconsistent states.

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

This deliberately explicit proof makes the universal case analysis visible
instead of hiding the entire argument behind opaque automation.
