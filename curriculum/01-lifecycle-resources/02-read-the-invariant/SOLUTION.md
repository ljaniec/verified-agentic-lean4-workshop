# Solution Note — Task 01.2

The intended invariant is:

```text
Active → sensorOpen ∧ logOpen
sensorOpen → Active
logOpen → Active
actuatorEnabled → Active
Unconfigured ∨ Finalized → all runtime resources are false
```

Therefore:

```text
Inactive, false, false, false  → safe
Inactive, true,  true,  false  → unsafe
Active,   true,  true,  true   → safe
Active,   false, true,  false  → unsafe
```

The forward and reverse resource implications are both necessary: an active node
must own its required resources, and those resources may not leak into a
non-active lifecycle mode.
