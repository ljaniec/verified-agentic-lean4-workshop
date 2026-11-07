# Task 02 — Behavior Tree to FSM Refinement

**Timebox: 11 minutes**

## Goal

Find one behavioral regression introduced by a handwritten FSM rewrite, repair
the rewrite, and prove that the corrected FSM produces the same observable
decision as the simplified Behavior Tree for every Boolean observation.

## Start

```bash
./workshop task start
```

## Work

1. Read the ordered `MISSION_TREE` in Python. The first matching branch wins.
2. Implement `counterexample_observation()` so the buggy FSM and BT disagree.
3. Repair `fsm_decision(...)` without changing the reference tree.
4. In Lean, complete `corrected_fsm_matches_bt`.
5. Keep the scope exact: this is a one-decision teaching model, not full
   BehaviorTree.CPP semantics.

## Done

```bash
./workshop task check
```

Stop at:

```text
WORKSHOP_TASK_OK 02-bt-refinement
```

Then run `./workshop task next`.
