# Reference Solutions Branch

> **Facilitator and post-workshop material. Do not use this as the participant checkout.**

This branch is maintained as a small overlay on top of the current participant
branch. Shared models, curriculum, setup scripts, and documentation should be
changed on `agent/initial-workshop-platform` first; this branch should contain
only the additional completed answers and facilitator-specific validation.

## Validate before the event

```bash
./workshop doctor
./workshop setup
./workshop check
./workshop scenario verify-solutions
```

Then validate each reference pair:

```bash
for scenario in lifecycle bt vda uncertainty; do
  ./workshop scenario solution "$scenario"
  ./workshop scenario check
done
```

## Use a separate worktree

```bash
git fetch origin
git worktree add ../verified-agentic-lean4-workshop-solutions \
  workshop/reference-solutions
```

Keep the participant and reference terminals visually distinct. Do not switch a
projected participant checkout onto this branch during a live exercise.

## Answer map

- Lifecycle Lean: `VerifiedAgenticWorkshop/Solutions/LifecycleResources.lean`
- Lifecycle Python: `solutions/python/lifecycle_resources.py`
- BT Lean: `VerifiedAgenticWorkshop/Solutions/BehaviorTreeRefinement.lean`
- BT Python: `solutions/python/behavior_tree_refinement.py`
- VDA Lean: `VerifiedAgenticWorkshop/Solutions/VDA5050Trace.lean`
- VDA Python: `solutions/python/vda5050_trace.py`
- Uncertainty Lean: `VerifiedAgenticWorkshop/Solutions/PerceptionPlannerContract.lean`
- Uncertainty Python: `solutions/python/perception_planner_contract.py`

Task-specific `SOLUTION.md` and `FACILITATOR.md` files live next to the matching
numbered curriculum stages.

## Publication warning

A Git branch is not access control. If the participant repository becomes public
before the event and the answers must remain unavailable, keep this overlay in a
private repository/fork or publish it only after the workshop.
