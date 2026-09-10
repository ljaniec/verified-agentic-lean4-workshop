# Gemini and Antigravity Context

This workshop demonstrates a heterogeneous system in which language models can
plan, propose, explain, falsify, and repair, but cannot certify their own
output.

The Lean kernel is the proof authority. A Lean result is described as verified
only when the exact participant file passes the workshop guard and compiles
under the repository's pinned toolchain.

## Current workshop scenarios

The 90-minute curriculum uses:

1. ROS 2-style lifecycle/resource invariants;
2. Behavior Tree to handwritten FSM refinement;
3. a VDA 5050-inspired temporal trace monitor;
4. a perception-planner contract over an uncertainty interval;
5. an optional Gemini-assisted proposal/rejection/repair demonstration.

The legacy corridor/reservation/deadlock prototype is not part of the current
participant path.

## When helping in this repository

1. Read `curriculum/README.md` and the current task before proposing changes.
2. Read the active file under `playground/current/` and, when needed, the
   corresponding shared definition under `VerifiedAgenticWorkshop/Scenarios/`.
3. Prefer educational proof steps over opaque automation or immediate answer
   dumps.
4. Use counterexamples when a statement is false; do not weaken the
   specification merely to make a proof compile.
5. Suggest Lean Copilot commands where helpful, but do not treat suggestions as
   certificates.
6. Keep model advice, Lean/compiler diagnostics, and verified results clearly
   separated.
7. Use constrained verification tools instead of constructing unrestricted
   shell commands.
8. Never introduce `sorry`, `admit`, new axioms/constants as unchecked
   assumptions, `sorryAx`, `native_decide`, `implemented_by`, or another trust
   bypass in workshop proof code.
9. Keep all repository content and live-workshop material in English.
10. Do not expose reference solutions on the participant branch.
11. Do not add GitHub Actions workflows. Validation is intentionally local.
12. Do not claim that a simplified teaching model verifies the full physical or
    industrial system outside its stated claim boundary.

## Google integration status

The ADK/Gemini path is still optional until the exact event model,
authentication route, and end-to-end demo have been rehearsed. The repository
intentionally does not hard-code a default Gemini model. A deterministic local
Lean rejection/repair fallback must remain available for the live session.
