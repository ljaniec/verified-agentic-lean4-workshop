# Facilitator Guide

## Recommended 90-minute flow

Use the numbered participant curriculum as the timing authority:

| Time | Activity |
|---:|---|
| 0–10 min | Setup, fleet/BT motivation, and trust boundary |
| 10–30 min | Lifecycle + sensor + log + actuator exercise |
| 30–62 min | Behavior Tree to handwritten FSM refinement |
| 62–69 min | VDA 5050-inspired temporal-conformance demo |
| 69–76 min | Perception-planner uncertainty demo |
| 76–87 min | Gemini/verification-loop demo or deterministic fallback |
| 87–90 min | Wrap-up |

The participant sequence is under [`../curriculum/`](../curriculum/README.md).
Every task is separately timeboxed and includes a recovery path.

## Keep reference answers out of the participant checkout

The participant branch intentionally has no completed answers and no
`scenario solution` command.

Reference answers are stored on:

```text
workshop/reference-solutions
```

For facilitator preparation, use a **separate checkout or worktree** rather than
switching the branch in the participant working directory:

```bash
git fetch origin
git worktree add ../verified-agentic-lean4-workshop-solutions \
  workshop/reference-solutions
```

Then keep two terminals clearly labeled:

```text
participant checkout  → agent/initial-workshop-platform
facilitator checkout  → workshop/reference-solutions
```

This prevents an accidental branch switch from exposing answers on the
projector or overwriting participant work.

### Important publication note

A Git branch is not access control. While the repository is private, the
reference branch can remain on GitHub. If the participant repository becomes
public before the event and answers must remain hidden, move the solution
branch to a private repository/fork or delete it from the public remote and
publish it only after the session.

## Pre-event acceptance

On a participant-equivalent clean clone:

```bash
./workshop doctor
./workshop setup
./workshop check
```

Exercise the four starters:

```bash
for scenario in lifecycle bt vda uncertainty; do
  ./workshop scenario start "$scenario"
  ./workshop scenario status
done
```

On the **reference-solutions worktree**, run the solution-branch validation and
all prepared demo commands. Do not infer that a solution still compiles merely
because the participant branch compiles.

After the first successful reference-machine setup, review and commit the
generated `lake-manifest.json` and `uv.lock`, then repeat acceptance from a
clean clone.

## Falling-behind policy

Do not solve every unfinished proof for the room.

The curriculum deliberately marks:

- lifecycle trace induction as stretch;
- BT trace lifting as stretch;
- VDA, uncertainty, and Gemini sections as facilitator-led demos.

When time expires, participants should let the scenario loader back up their
current work and move with the room. Later demos do not depend on their local
proof being complete.

Offer progressively stronger help:

1. restate the goal in plain language;
2. name the relevant definition;
3. suggest the proof shape or tactic category;
4. show a smaller analogous proof;
5. only after the session, point to the reference-solutions branch.

## Demo policy

### VDA demo

Use the prepared reference checkout to show:

- individually valid-looking messages forming an invalid temporal trace;
- typed violation diagnostics;
- the corresponding checked Lean claims.

Keep the claim narrow: this is a VDA 5050-inspired teaching profile, not full
standard certification.

### Uncertainty demo

Use the point-estimate counterexample first, then reveal the set-valued
uncertainty contract and its universal Lean theorem.

### Gemini demo

Use the live Gemini/agent path only after end-to-end testing on the exact event
environment. Prepare a deterministic fallback consisting of:

1. one known-invalid Lean candidate;
2. the corresponding real Lean diagnostic;
3. one repaired candidate;
4. a successful local checker result.

The audience must see the same trust separation even if cloud access fails.

## Event infrastructure

- Prefer pairs or groups of two/three for the exercises.
- Keep Lean, Lean Copilot, and Python participant-local.
- Do not require Gemini credentials for the two core exercises.
- Prepare repository, Mathlib cache, Lean Copilot cache, and Python artifacts
  offline.
- Keep any experimental local model optional and outside the critical path.
- Never expose participant credentials or add them to repository files.
- GitHub Actions remain disabled; validation is local.

## Claim discipline

- Lifecycle resources: simplified ROS 2-style application invariant, not a full
  ROS 2 lifecycle semantics.
- Behavior Tree: simplified single-decision Fallback model, not full
  BehaviorTree.CPP semantics.
- VDA 5050: teaching profile, not certification of the complete standard.
- Uncertainty: one-dimensional interval contract, not a full perception or
  motion-planning safety proof.
- Gemini: proposal/repair layer; verification authority remains outside the
  model.
