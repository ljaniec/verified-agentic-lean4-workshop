# Solution Note — Task 01.1

The deliberately faulty deactivation preserves all three active resource flags
while changing only the mode.

For the provided active state:

```text
before: Active,   sensor=true, log=true, actuator=true
after:  Inactive, sensor=true, log=true, actuator=true
```

The corresponding Python observation is:

```python
buggy = buggy_step(ACTIVE_STATE, Event.DEACTIVATE)
assert buggy.mode is Mode.INACTIVE
assert not safe(buggy)
```

The important teaching point is not merely that the actuator remained enabled.
The strengthened invariant also rejects an inactive state that retains the
sensor or log even when actuator authority is false.
