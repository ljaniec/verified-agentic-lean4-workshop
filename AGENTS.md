# Agent Contract — Current Browser Workshop

The current event is the 45-minute browser route in `course/browser/README.md`.
`presentation/workshop-slides.pdf` and `presentation/workshop-agenda.pdf` define
the content and timing. `presentation/speaker_notes.md` follows all 18 slides;
its PDF is the print edition. Earlier courses remain in Git history only.

## Participant workflow

1. Read the browser task guide and the selected complete starter.
2. Edit only the final proof after `:= by`; keep definitions and statement fixed.
3. In Lean Web, wait for checking and inspect All Messages.
4. For a local copy, use `playground/current/Current.lean` and run
   `./workshop browser check playground/current/Current.lean` after each change.
5. Stop when the exact file is accepted without errors, warnings, or bypasses.

The unfinished starters are deliberate. Do not edit shared models or regenerate
the bundle to complete a participant task. Open `course/browser/checkpoints/`
only when the participant requests the answer or during the scheduled walkthrough.

## Trust boundary

AI output is never a certificate. A Lean theorem is accepted only after the
exact file compiles with the selected toolchain. Never weaken the specification.
Never add or use `sorry`, `admit`, new axioms/constants as proof assumptions,
`Lean.sorryAx`, `native_decide`, `implemented_by`, or another proof bypass.
Do not modify the static guard to permit a candidate.

The shared definitions under `VerifiedAgenticWorkshop/Scenarios/` are the model.
A theorem about that model does not certify the complete physical system.

## Repository maintenance

An explicit request to audit, organize, or update the workshop is maintenance,
not a participant task. Work within that scope. Preserve specifications and
ignored participant work. Use a `codex/` branch and the requested PR workflow.

Run `./workshop browser check` and the relevant local checks after meaningful
changes. `./workshop check` includes the pinned Lean build, browser checkpoints,
Python checks, and scanner regression tests. The slide's `./workshop task check`
is a compatibility alias for the browser bundle gate, not a branch transition.

All repository material is in English. GitHub Actions are intentionally disabled.
Do not commit credentials, model weights, participant data, caches, or runtime
artifacts. The event needs no cloud account or model installation.
