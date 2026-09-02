# Solution Note — Task 02.2

A minimal counterexample is:

```python
Observation(
    cancel_requested=True,
    goal_reached=False,
    path_available=True,
)
```

The reference Behavior Tree checks cancellation first and returns
`STOP_AND_CANCEL`. The buggy handwritten FSM checks path availability first and
returns `DRIVE`.

This concrete disagreement is the regression that motivates the refinement
theorem.
