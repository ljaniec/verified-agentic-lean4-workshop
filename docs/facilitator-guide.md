# Facilitator guide — the 45-minute event

**Authority:** [supplied presentation](../presentation/workshop-slides.pdf) and
[agenda / talk cues](../presentation/workshop-agenda.pdf). Start the timer after
the Lean introduction. The [browser task guide](../course/browser/README.md)
is the participant handout. No installation or model setup belongs in this slot.

| Stop at | Task | Maximum explanation |
|---:|---|---|
| 4:00 | 00 — browser checker and trust boundary | 45 seconds |
| 12:00 | 01 — lifecycle resources | 60 seconds before work; 45 seconds for solution |
| 23:00 | 02 — BT → FSM refinement | 75 seconds before work; 60 seconds for solution |
| 29:00 | 03 — temporal trace conformance | 45 seconds total |
| 35:00 | 04 — uncertainty contract | 45 seconds total |
| 42:00 | 05 — proposal, rejection, repair | 60 seconds total |
| 45:00 | Wrap-up | 3 minutes |

## Before opening the room

Print the [current speaker notes](../presentation/speaker_notes.pdf), then follow
the [rehearsal checklist](facilitator-rehearsal.md). Open the supplied
slides, agenda, browser task guide, and [Lean Web](https://live.lean-lang.org/)
in advance. Keep a local clone and the installed pinned Lean toolchain ready
for an internet outage. `./workshop browser check` is the minimal event gate.

The event PDF includes a repaired QR code on its setup slide. The supplied original remains in Git history. A [standalone QR](../presentation/assets/lean-web-qr.svg)
is also available; see [presentation provenance](../presentation/README.md).

## Delivery cues

- **00:** human and model are proposers; only the checker accepts the proof.
- **01:** the mode changes, but open sensor/log handles violate the invariant.
  The repaired step covers 192 modeled combinations, assuming a safe input.
- **02:** cancellation has priority over path availability. The corrected FSM
  agrees with the BT on all eight observations.
- **03:** two individually well-formed `(7, 0)` orders form a stale-update trace.
  Show `.error .orderUpdateNotIncreasing`; this is a teaching profile.
- **04:** show the number line first: path `[0, 8]`, estimate `10`, interval
  `[6, 10]`. The concrete decisions differ. Coverage of the real obstacle is
  an external assumption.
- **05:** paste the deliberately wrong `rfl` starter, show its actual diagnostic,
  replace the final proof with `decide`, and show acceptance. A live assistant
  is optional; use the deterministic sequence if it is slow or unavailable.

Open a [completed checkpoint](../course/browser/checkpoints/) only at the
scheduled walkthrough. Each is self-contained, so no branch switch or earlier
participant proof is required. Do not label a file accepted until the checker
has finished without errors or warnings.

## Recovery and hard stops

If two minutes behind, stop explaining implementation details. Show the result,
state its scope, and move on. Cut tactic explanations first; then make Tasks 03
and 04 presenter demos; then state Task 02's eight-case result without waiting
for everyone. Save participant text before replacing it with the next task.

If the browser fails, project the locally checked bundle with
`./workshop browser check`; for a particular edited file, use
`./workshop browser check playground/current/Current.lean`.
Do not begin dependency/model downloads during the event.

## Close at minute 45

We verified properties of explicit models under explicit assumptions. Engineers
still own model fidelity and the choice of requirement. AI proposes; Lean
checks. A formally checked answer to the wrong question is still the wrong
engineering result. Take new discussion topics after the practical sequence.
