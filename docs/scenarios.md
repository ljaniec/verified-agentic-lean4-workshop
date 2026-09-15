# Workshop Scenarios

The first 90-minute workshop uses four formalized robotics scenarios with one
repeated pattern:

```text
executable model -> counterexample or monitor -> Lean claim -> checked result
```

The participant branch contains:

- shared Lean scenario models under `VerifiedAgenticWorkshop/Scenarios/`;
- unsolved Lean templates in `exercises/lean/`;
- unsolved Python templates in `exercises/python/`;
- numbered instructions under `curriculum/`.

Completed Lean/Python answers are intentionally maintained separately on the
facilitator reference branch and are not loadable from the participant CLI.

Use the scenario loader instead of copying files manually:

```bash
./workshop scenario start lifecycle
./workshop scenario status
./workshop scenario check
```

Loading another starter first backs up the current editable pair under
`playground/backups/`.

## 1. Lifecycle resources

**Role:** shared introductory exercise.

A managed ROS 2-style node has a lifecycle mode, but the application also owns
a sensor handle, a log resource, and actuator authority. The deliberately
faulty `deactivate` transition changes only the lifecycle mode. The exercise
exposes the resulting unsafe state and repairs the transition.

The intended application invariant includes both directions of resource
ownership:

```text
Active → sensorOpen ∧ logOpen
sensorOpen → Active
logOpen → Active
actuatorEnabled → Active
```

plus cleanup requirements for terminal/unconfigured modes.

Participants use Python to inspect the bug and exhaustively check the finite toy
state space, then Lean to establish one-step invariant preservation. A stretch
task lifts that result to every finite lifecycle-event trace.

This is a simplified application-level lifecycle model, not a complete ROS 2
lifecycle semantics.

Reference: <https://design.ros2.org/articles/node_lifecycle.html>

Detailed tasks: [`../curriculum/01-lifecycle-resources/`](../curriculum/01-lifecycle-resources/README.md)

## 2. Behavior Tree refinement

**Role:** main exercise.

The reference policy is a simplified Fallback of condition-action branches.
Cancellation has the highest priority. A deliberately buggy handwritten
replacement checks path availability first and can therefore issue a drive
decision after cancellation.

Participants:

1. read the reference priority semantics;
2. construct a concrete counterexample to the buggy rewrite;
3. repair the Python FSM;
4. prove pointwise behavioral equivalence in Lean;
5. optionally lift pointwise equivalence to finite observable traces.

The model intentionally omits `RUNNING`, asynchronous actions, blackboard state,
and concurrent subtrees. It isolates the refinement idea before those features
are added.

Reference: <https://www.behaviortree.dev/docs/nodes-library/FallbackNode/>

### Real-world motivation

This scenario is motivated by an industrial fleet-management experience in
which a substantial Behavior Tree implementation became difficult to maintain
and was replaced with handwritten robot-state transition logic. The rewrite had
no machine-checked statement of which observable behavior, cancellation
priority, or safety invariant had to remain unchanged. A refinement theorem
turns that implicit expectation into a regression contract.

Detailed tasks: [`../curriculum/02-behavior-tree-refinement/`](../curriculum/02-behavior-tree-refinement/README.md)

## 3. VDA 5050-inspired semantic trace monitor

**Role:** short facilitator demonstration.

A message can be structurally well-typed while a sequence is semantically
invalid. The teaching monitor tracks a small subset of temporal state such as
order/update identity and reported node progress.

It demonstrates:

- stale order updates;
- order/state mismatch style failures;
- regressing progress;
- typed violation diagnostics;
- the first rejected message index on the Python side;
- corresponding checked Lean examples on the reference branch.

This is a deliberately small VDA 5050-inspired profile, not certification of
the full standard.

Official specification and JSON schemas:
<https://github.com/VDA5050/VDA5050>

Demo steps: [`../curriculum/03-vda5050-demo/`](../curriculum/03-vda5050-demo/README.md)

## 4. Perception-planner uncertainty contract

**Role:** short mathematical demonstration.

The perception component supplies a closed interval of possible obstacle
positions. The planner may accept a path interval only when the two intervals
are separated; otherwise it falls back/replans.

The demo contrasts this with a weaker point-estimate baseline. For path
`[0, 8]`, a point estimate at `10` appears safe while an uncertainty interval
`[6, 10]` overlaps the path.

The checked reference theorem states that whenever the set-aware planner
accepts, every point allowed by the path is different from every obstacle
position allowed by the uncertainty interval.

The one-dimensional interval is intentionally small. The reusable idea is the
contract between an uncertain perception output and a planner, not the geometry
itself.

Demo steps: [`../curriculum/04-uncertainty-demo/`](../curriculum/04-uncertainty-demo/README.md)

## 5. Gemini-assisted verification finale

The final guided demo is organized separately because the Google agent
integration is still being finalized. Its critical concept does not depend on
cloud availability:

```text
proposal -> constrained verifier -> rejection/feedback -> repair -> verification
```

The live Gemini path is used only after end-to-end rehearsal. A deterministic
local fallback must demonstrate the same trust boundary.

Demo steps: [`../curriculum/05-gemini-verification-demo/`](../curriculum/05-gemini-verification-demo/README.md)

## Timing

| Time | Activity |
|---:|---|
| 0–10 min | Setup, motivation, trust boundary |
| 10–30 min | Lifecycle resources exercise |
| 30–62 min | Behavior Tree refinement exercise |
| 62–69 min | VDA 5050-inspired trace-monitor demo |
| 69–76 min | Perception-planner uncertainty demo |
| 76–87 min | Gemini/verification-loop demo or fallback |
| 87–90 min | Wrap-up |

The command-by-command instructor sequence is in
[`live-demo-script.md`](live-demo-script.md).
