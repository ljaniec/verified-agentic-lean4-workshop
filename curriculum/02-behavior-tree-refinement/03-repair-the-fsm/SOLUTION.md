# Solution Note — Task 02.3

The corrected handwritten FSM must preserve the reference branch priority:

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

Because the observation space contains three Booleans, the reference Python
implementation checks all eight combinations against `bt_decision`.
