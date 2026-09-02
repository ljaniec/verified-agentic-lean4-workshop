# Solution Note — Task 01.4

The raw teaching state space contains `4 × 2 × 2 × 2 = 32` states. The
reference implementation enumerates all of them and checks every event from
every state satisfying `safe`:

```python
def preservation_holds() -> bool:
    return all(
        safe(step(state, event))
        for state in all_states()
        if safe(state)
        for event in Event
    )
```

This is exhaustive for the finite Python abstraction. The Lean theorem remains a
separate checked logical statement and is the pattern that survives when a
state space is no longer conveniently enumerable.
