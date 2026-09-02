# Solution Note — Task 02.1

The reference priority is:

```text
1. cancel requested  → STOP_AND_CANCEL
2. goal reached      → REPORT_SUCCESS
3. path available    → DRIVE
4. otherwise         → REQUEST_PLAN
```

The four observations listed in the participant task therefore evaluate to
`STOP_AND_CANCEL`, `REPORT_SUCCESS`, `DRIVE`, and `REQUEST_PLAN` respectively.

The model describes one observable decision step, not full BehaviorTree.CPP
execution semantics.
