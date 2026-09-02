# Solution Note — Task 01.4

The finite state space contains `4 × 2 × 2 × 2 = 32` raw states. The reference
implementation enumerates them and checks every event from every state that
satisfies `safe`:

```python
def preservation_holds() -> bool:
    return all(
        safe(step(state, event))
        for state in all_states()
        if safe(state)
        for event in Event
    )
```

This is an exhaustive executable check for this finite Python abstraction. It
is still pedagogically distinct from the Lean theorem: the theorem is a checked
logical statement over the formal model and scales conceptually when convenient
state enumeration disappears.
