# Solution Note — Task 02.3

The corrected handwritten FSM preserves the reference priority:

```python
def fsm_decision(observation: Observation) -> Decision:
    if observation.cancel_requested:
        return Decision.STOP_AND_CANCEL
    if observation.goal_reached:
        return Decision.REPORT_SUCCESS
    if observation.path_available:
        return Decision.DRIVE
    return Decision.REQUEST_PLAN
```

The reference Python solution compares this function with `bt_decision` for all
eight combinations of the three Boolean observation fields.
