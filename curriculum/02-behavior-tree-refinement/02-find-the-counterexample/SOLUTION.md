# Solution Note — Task 02.2

The participant Python TODO can be completed as:

```python
def counterexample_observation() -> Observation:
    return Observation(
        cancel_requested=True,
        goal_reached=False,
        path_available=True,
    )
```

The reference Behavior Tree checks cancellation first and returns
`STOP_AND_CANCEL`. The buggy handwritten FSM checks path availability first and
returns `DRIVE`.

The corresponding Lean checkpoint is the concrete theorem over the shared
`cancelWhilePathAvailable` observation. A direct proof is:

```lean
by
  decide
```

The important progression is:

```text
reason about priority
→ construct one counterexample
→ execute it in Python
→ certify the concrete mismatch in Lean
```

This disagreement is the regression that motivates the later universal
refinement theorem.
