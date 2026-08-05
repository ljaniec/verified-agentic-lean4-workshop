# Workshop Scenarios

The first 90-minute workshop uses four scenarios with one repeated pattern:

```text
executable model -> counterexample or monitor -> Lean theorem -> checked result
```

Each scenario has:

- an unsolved Lean template in `exercises/lean/`;
- an unsolved Python template in `exercises/python/`;
- a compiled Lean reference solution in `VerifiedAgenticWorkshop/Solutions/`;
- an executable Python reference solution in `solutions/python/`.

Use the scenario loader instead of copying files manually:

```bash
./workshop scenario start lifecycle
./workshop scenario check
./workshop scenario solution lifecycle
./workshop scenario check
```

## 1. Lifecycle resources

**Role:** shared introductory exercise.

A managed ROS 2 node has a lifecycle mode, but the application also owns a
sensor handle, a log file, and actuator authority. The deliberately faulty
`deactivate` transition changes only the lifecycle mode. The exercise exposes
the resulting unsafe state and proves that the corrected transition system
preserves the application invariant.

This follows the ROS 2 managed-node design: `Unconfigured`, `Inactive`,
`Active`, and `Finalized` are primary states; activation may acquire resources
held only while active, and deactivation should reverse those changes.

Reference: <https://design.ros2.org/articles/node_lifecycle.html>

## 2. Behavior Tree refinement

**Role:** main exercise.

The reference policy is a simplified Fallback whose children are
condition-action Sequences. Cancellation has the highest priority. A
handwritten replacement checks path availability first and can therefore issue
a drive command after cancellation. Participants prove the counterexample and
then prove observational equivalence of the repaired FSM and the reference BT
for every Boolean observation.

The model intentionally omits `RUNNING`, asynchronous actions, and blackboard
state. It isolates the refactoring contract before those features are added.

Reference: <https://www.behaviortree.dev/docs/nodes-library/FallbackNode/>

### Real-world motivation

This scenario is based on an industrial fleet-management experience. A large
Behavior Tree implementation became difficult for another developer to debug
and extend, so a substantial part was discarded and rewritten as handwritten
robot-state transition code. The rewrite had no machine-checked statement of
which observable behavior, cancellation priority, or safety invariant had to
be preserved. A refinement theorem would have turned that implicit expectation
into a regression contract.

## 3. VDA 5050 semantic trace monitor

**Role:** short instructor demonstration.

The exercise uses a deliberately small typed profile inspired by VDA 5050
3.0. A message can be structurally well-typed while a sequence is semantically
invalid. The monitor checks:

- a new order starts with update ID 0;
- updates for the current order increase;
- state messages refer to the current order;
- reported node progress never decreases.

The demo rejects a stale update and a regressing state trace. It is not a
complete VDA 5050 verifier and must not be described as certification of the
full standard.

Official specification and JSON schemas:
<https://github.com/VDA5050/VDA5050>

## 4. Perception-planner uncertainty contract

**Role:** short mathematical demonstration.

The perception component supplies a closed interval of possible obstacle
positions. The planner may accept a path interval only when the two intervals
are separated; otherwise it falls back or replans. Python demonstrates the
executable policy over finite integer examples. Lean proves the universal
contract:

> If the planner accepts, no path point equals any obstacle position permitted
> by the uncertainty interval.

The one-dimensional interval is intentionally small. It introduces the logical
shape later used for boxes, polytopes, reachable sets, or conformal prediction
sets without requiring those representations during the first workshop.

## Suggested timing

| Time | Activity |
|---:|---|
| 0-12 min | Trust boundary, Lean, Lean Copilot, and executable models |
| 12-32 min | Lifecycle resources exercise |
| 32-67 min | Behavior Tree to FSM refinement exercise |
| 67-77 min | VDA 5050 trace-monitor demonstration |
| 77-87 min | Perception-planner uncertainty demonstration |
| 87-90 min | Summary and next steps |
