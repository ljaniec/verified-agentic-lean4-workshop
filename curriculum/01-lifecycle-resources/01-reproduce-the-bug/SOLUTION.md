# Solution Note — Task 01.1

The buggy `DEACTIVATE` transition changes the mode to `INACTIVE` but carries
forward the active resource flags. Starting from `ACTIVE_STATE`, the result is
therefore inactive with sensor/log/actuator resources still enabled, and
`safe(...)` rejects it.

```python
buggy = buggy_step(ACTIVE_STATE, Event.DEACTIVATE)
assert buggy.mode is Mode.INACTIVE
assert not safe(buggy)
```

The important observation is that checking only the lifecycle enum would miss
the application-level resource inconsistency.
