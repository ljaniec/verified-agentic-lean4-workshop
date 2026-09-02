# Solution Note — Task 02.2

A minimal counterexample is:

```python
Observation(
    cancel_requested=True,
    goal_reached=False,
    path_available=True,
)
```

The reference Behavior Tree checks cancellation first:

```text
bt_decision(...) = STOP_AND_CANCEL
```

The buggy handwritten FSM checks path availability first:

```text
buggy_fsm_decision(...) = DRIVE
```

This is the concrete regression that motivates the refinement theorem.
