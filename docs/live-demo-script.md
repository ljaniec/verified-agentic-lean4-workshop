# Live Demonstration Script

Use this together with the numbered [`curriculum/`](../curriculum/README.md).
The participant branch deliberately contains no answers, so the instructor
should prepare two separate checkouts before the event.

## 0. Prepare two clearly labeled worktrees

Participant-equivalent checkout:

```text
agent/initial-workshop-platform
```

Reference checkout:

```text
workshop/reference-solutions
```

One possible setup is:

```bash
git fetch origin
git worktree add ../verified-agentic-lean4-workshop-solutions \
  workshop/reference-solutions
```

Never switch the projected participant terminal onto the reference branch during
an exercise.

## 1. Preflight

### Participant checkout

```bash
./workshop doctor
./workshop setup
./workshop check
```

### Reference checkout

Run its complete reference-solution validation and each prepared demo once
before the event. Record the expected output locally as a fallback.

No GitHub Actions service is involved.

## 2. Lifecycle exercise

Follow:

```text
curriculum/01-lifecycle-resources/
```

On the participant checkout:

```bash
./workshop scenario start lifecycle
./workshop scenario status
```

Let participants reproduce the buggy deactivation, repair the Python
transition, check the finite toy state space, and work on the one-step Lean
invariant proof.

The trace-induction task is optional when time is tight.

If you need to show the completed result after the hands-on portion, use the
**reference checkout** rather than replacing the participant file.

Emphasize:

- lifecycle mode is only part of application state;
- active mode requires its resources;
- retained sensor/log/actuator resources require active mode;
- the repaired transition preserves the invariant;
- the formal trace theorem lifts local preservation to finite executions.

## 3. Behavior Tree refinement exercise

Follow:

```text
curriculum/02-behavior-tree-refinement/
```

On the participant checkout:

```bash
./workshop scenario start bt
```

Have participants reason about the reference priority before searching for the
counterexample.

The key observation contains both a cancellation request and an available path.
The reference policy prioritizes cancellation; the buggy rewrite may drive.

Participants repair the Python FSM and prove pointwise equivalence in Lean. The
trace-lifting theorem is a stretch task.

Again, use the reference worktree only for the prepared completed proof.

## 4. VDA 5050-inspired demo

Follow:

```text
curriculum/03-vda5050-demo/
```

Run the prepared monitor from the reference checkout. Show:

```text
order(7, update=0)
order(7, update=0)
```

and a state trace whose reported node sequence regresses.

Make the structured diagnostic visible: violation kind plus first rejected
message index.

Then show the corresponding Lean claims.

Claim boundary: this is a VDA 5050-inspired teaching profile, not full
conformance certification.

## 5. Perception-planner uncertainty demo

Follow:

```text
curriculum/04-uncertainty-demo/
```

Use:

```text
path interval          [0, 8]
point estimate         10
uncertainty interval   [6, 10]
```

First show why the point-estimate policy accepts. Then reveal why the
set-valued policy falls back and show the universal Lean theorem for accepted
plans.

Claim boundary: the model is one-dimensional and demonstrates the contract
shape, not a complete perception/planning safety proof.

## 6. Gemini-assisted verification finale

Follow:

```text
curriculum/05-gemini-verification-demo/
```

Use the live Gemini/agent integration only after it has passed an end-to-end
rehearsal on the event setup.

The intended sequence is:

```text
Gemini candidate
    → constrained checker call
    → Lean rejection
    → diagnostic returned to Gemini
    → repaired candidate
    → Lean verification
```

Prepare a deterministic fallback using a known-invalid candidate and a known
repaired candidate. The audience must see the same trust boundary even when
cloud access is unavailable.

## 7. Recovery during the event

The participant scenario loader backs up unfinished work before switching to a
new starter:

```bash
./workshop scenario status
./workshop scenario clean
```

Do not expose the reference branch simply because one participant falls behind.
Use the curriculum's hints and timeboxes; later demos are independent of local
exercise completion.

If Gemini is unavailable, use the deterministic local verifier demo. If Lean
Copilot models are unavailable, use standard Mathlib/Lean suggestions such as
`simp?`, `exact?`, `apply?`, and `aesop?` while keeping the same verification
message.
