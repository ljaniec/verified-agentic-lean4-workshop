# Rehearsal checklist — browser workshop

Use the supplied [agenda](../presentation/workshop-agenda.pdf) for all stops.
Run these checks on the actual presenter laptop before the room arrives.

## Minimal event gate

```bash
lean --version
./workshop browser check
```

Run from the repository root so `elan` selects `lean-toolchain` (4.28.0).
Expected final line: `BROWSER_WORKSHOP_OK (6 checkpoints; 5 expected starter rejections)`.
The checker prints Task 05's real Lean diagnostic. The completed file must pass;
a timeout, missing import, or unrelated starter error is not a successful gate.
No Mathlib, Lean Copilot, Python packages, or cloud credentials are needed.

## Rehearse what participants see

1. Open [Lean Web](https://live.lean-lang.org/) and note the selected Lean version.
2. Follow [Task 00](../course/browser/starters/00_VerificationGate.lean) from Raw
   file to pasted text to an error-free checker result.
3. Paste each Task 01–04 starter. Confirm it is intentionally unfinished.
   Apply the corresponding proof from the slide checkpoint and wait for checking.
4. Paste Task 05 with `rfl`, read its actual rejection, then change only `rfl` to
   `decide`. Confirm the entire file is accepted.
5. Keep the [completed files](../course/browser/checkpoints/) open for scheduled
   walkthroughs; keep each task inside the agenda's timebox.

A local success is evidence for the pinned local version, not a claim that the
hosted service or event Wi-Fi was tested. Check those on the event connection.

## Prepare recovery

- Keep the PDFs, task files, and installed Lean toolchain on the presenter laptop.
- Check the [offline workflow](offline-mode.md) with networking unavailable.
- Keep the printed browser URL and [standalone QR](../presentation/assets/lean-web-qr.svg)
  available. The event deck repairs the supplied original's QR placeholder.
- If a model is unavailable, use Task 05's deterministic rejection/repair.
- Save any active participant text before moving to another self-contained task.

## Additional repository acceptance

For maintainers with the full local project prepared:

```bash
./workshop check --lean-only
uv sync --group dev --locked
./workshop check
```

The acceptance checks need no cloud credentials. The six browser tasks were also
walked through in Lean Web on 2026-11-14 using its default Lean 4.36.0-rc2:
all completed proofs passed, and the intended starter rejections were observed.

Print [speaker_notes.pdf](../presentation/speaker_notes.pdf). Its five A4 pages
follow all 18 current slides. Older courses and model demos have been removed
from `main` so they cannot distract participants from the checked event path.
