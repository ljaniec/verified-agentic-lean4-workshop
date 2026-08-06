# Live Demonstration Script

This script is designed for the instructor machine. Run it once from a clean
clone before the event and keep the terminal history available as a fallback.

## 0. Preflight

```bash
./workshop doctor
./workshop check
./workshop scenario verify-solutions
```

Expected result: all repository checks and all four reference scenarios pass.
No GitHub Actions service is involved.

## 1. Lifecycle: a mode change is not resource cleanup

```bash
./workshop scenario start lifecycle
./workshop scenario status
./workshop scenario check
```

Expected result: the starter fails because the Lean proofs and corrected Python
transition are incomplete. This is intentional.

Show the buggy transition in both languages. Its `deactivate` branch changes the
mode but leaves the sensor, log, and actuator fields unchanged. Ask the audience
which invariant is violated before revealing the formal statement.

Load the reference pair:

```bash
./workshop scenario solution lifecycle
./workshop scenario status
./workshop scenario check
```

Point out:

- Python exhaustively checks the finite state/event model;
- Lean proves preservation for an arbitrary safe state and event;
- the additional Lean theorem lifts the one-step invariant to every finite
  lifecycle-event trace.

Claim boundary: this proves properties of the workshop abstraction, not of an
arbitrary ROS 2 implementation or hardware driver.

## 2. Behavior Tree refactoring: preserve observable behavior

```bash
./workshop scenario start bt
./workshop scenario check
```

Use the observation:

```text
cancel_requested = true
path_available = true
```

The Behavior Tree selects `STOP_AND_CANCEL`; the buggy handwritten FSM selects
`DRIVE` because it tests path availability first.

```bash
./workshop scenario solution bt
./workshop scenario check
```

Point out the two proof levels:

1. a concrete counterexample disproves the buggy refactoring;
2. pointwise equivalence of the corrected FSM and BT lifts to equality of every
   finite observable decision trace.

Claim boundary: the first model intentionally omits `RUNNING`, asynchronous
nodes, halting, and blackboard mutation. These features belong in later
refinement layers.

## 3. VDA 5050-inspired monitor: valid messages, invalid trace

```bash
./workshop scenario solution vda
./workshop scenario check
```

Show the two invalid traces:

```text
order(7, update=0)
order(7, update=0)
```

and:

```text
state(order=7, last_node=4)
state(order=7, last_node=3)
```

The detailed monitor reports respectively:

```text
ORDER_UPDATE_NOT_INCREASING at message index 1
NODE_SEQUENCE_REGRESSED at message index 2
```

Point out the distinction:

```text
schema/type validation checks one message
trace conformance checks temporal relationships between messages
```

Claim boundary: this is a small teaching profile inspired by VDA 5050, not a
full conformance or certification tool.

## 4. Perception-planner contract: point estimate versus uncertainty set

```bash
./workshop scenario solution uncertainty
./workshop scenario check
```

Use:

```text
path interval       [0, 8]
point estimate      10
uncertainty interval [6, 10]
```

The point-estimate baseline accepts because 10 is outside the path. The robust
policy falls back because the certified uncertainty interval overlaps the path.
Lean proves that whenever the robust policy accepts, every point in the path is
different from every point allowed by the uncertainty interval.

Claim boundary: the demo uses one-dimensional integer intervals. The theorem
shape, rather than the geometry, is the reusable lesson.

## Recovery during the event

Loading a new starter or solution automatically backs up the current editable
pair under `playground/backups/`.

```bash
./workshop scenario status
./workshop scenario clean
```

If cloud access or Gemini fails, continue with these four local scenarios and
Lean Copilot. If Lean Copilot is unavailable, use `simp?`, `exact?`, `apply?`,
`aesop?`, and the committed reference solutions.
