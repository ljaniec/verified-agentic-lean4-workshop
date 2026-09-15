# 90-Minute Workshop Plan

## Learning goal

Participants should leave with one operational idea: AI-generated code and
executable tests are useful for proposing and exploring, while explicit
invariants and refinement theorems let an independent verifier decide whether a
formal claim is actually established.

## Run of show

| Time | Activity |
|---:|---|
| 0–10 min | Setup, real fleet/BT motivation, trust boundary |
| 10–30 min | Exercise 1: lifecycle + sensor + log + actuator |
| 30–62 min | Exercise 2: Behavior Tree to handwritten FSM refinement |
| 62–69 min | Demo: VDA 5050-inspired temporal conformance |
| 69–76 min | Demo: perception-planner uncertainty contract |
| 76–87 min | Demo: Gemini proposal → Lean rejection → repair → verification |
| 87–90 min | Wrap-up |

The detailed participant path is [`../curriculum/`](../curriculum/README.md).
Every task/demo step has a separate folder and explicit timebox.

## Participant commands

```bash
./workshop scenario start lifecycle
./workshop scenario check

./workshop scenario start bt
./workshop scenario check
```

The VDA and uncertainty sections are facilitator-led and do not depend on the
participant finishing either stretch proof.

Reference solutions are deliberately absent from the participant branch. The
facilitator uses a separate `workshop/reference-solutions` checkout when a
completed implementation must be demonstrated.

## Falling-behind policy

The following are optional stretch work during the live 90 minutes:

- lifecycle finite-trace induction;
- Behavior Tree finite-trace lifting.

When the room moves on, the scenario loader backs up the participant's current
files. The demos use a prepared facilitator checkout, so unfinished participant
work does not block the workshop.

## Scope discipline

The first workshop does not attempt full ROS 2 lifecycle semantics, complete
BehaviorTree.CPP execution, VDA 5050 certification, or a full perception/motion-
planning safety proof. Every model names its simplifications so the checked
claim remains precise.

The live Gemini/agent integration is also outside the critical path until it has
passed end-to-end rehearsal. A deterministic local proposal/rejection/repair
fallback must always be available.
