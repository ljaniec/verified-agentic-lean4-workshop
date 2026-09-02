# Solution Note — Task 01.3

The reference implementation keeps the transition model deliberately small:

```python
def step(state: State, event: Event) -> State:
    if state.mode is Mode.UNCONFIGURED and event is Event.CONFIGURE:
        return State(Mode.INACTIVE, False, False, False)
    if state.mode is Mode.INACTIVE and event is Event.ACTIVATE:
        return ACTIVE_STATE
    if state.mode is Mode.ACTIVE and event is Event.DEACTIVATE:
        return State(Mode.INACTIVE, False, False, False)
    if state.mode is Mode.INACTIVE and event is Event.CLEANUP:
        return INITIAL
    if event is Event.SHUTDOWN:
        return State(Mode.FINALIZED, False, False, False)
    if event is Event.RECOVER_FROM_ERROR:
        return INITIAL
    return state
```

The critical repair is deactivation: construct a clean inactive state instead
of copying active resource ownership forward.
