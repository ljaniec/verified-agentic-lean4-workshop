# Reference Solutions Branch

> **Facilitator/post-workshop branch — do not use as the participant checkout.**

This branch was snapshotted from the complete workshop development state before
reference answers were removed from the participant branch.

It contains:

- completed Lean reference proofs under `VerifiedAgenticWorkshop/Solutions/`;
- completed Python reference implementations under `solutions/python/`;
- the `./workshop scenario solution <name>` command;
- `./workshop scenario verify-solutions`;
- the same numbered `curriculum/` structure used by participants.

## Validate this branch before the event

```bash
./workshop doctor
./workshop setup
./workshop check
./workshop scenario verify-solutions
```

Then run each reference pair:

```bash
for scenario in lifecycle bt vda uncertainty; do
  ./workshop scenario solution "$scenario"
  ./workshop scenario check
done
```

## Use a separate worktree

Do not switch a projected participant checkout to this branch. Prefer:

```bash
git worktree add ../verified-agentic-lean4-workshop-solutions \
  workshop/reference-solutions
```

## Publication warning

A Git branch is not access control. If the participant repository becomes
public before the event and solutions must remain hidden, keep this branch off
the public remote (for example in a private repository/fork) until the session
ends.

## Answer map

### Lifecycle

- Python: `solutions/python/lifecycle_resources.py`
- Lean: `VerifiedAgenticWorkshop/Solutions/LifecycleResources.lean`

### Behavior Tree refinement

- Python: `solutions/python/behavior_tree_refinement.py`
- Lean: `VerifiedAgenticWorkshop/Solutions/BehaviorTreeRefinement.lean`

### VDA 5050-inspired monitor

- Python: `solutions/python/vda5050_trace.py`
- Lean: `VerifiedAgenticWorkshop/Solutions/VDA5050Trace.lean`

### Perception-planner uncertainty

- Python: `solutions/python/perception_planner_contract.py`
- Lean: `VerifiedAgenticWorkshop/Solutions/PerceptionPlannerContract.lean`

The following `SOLUTION.md` / facilitator notes inside `curriculum/` explain how
the completed code maps to each live task.
