# Offline fallback

The live event uses [Lean Web](https://live.lean-lang.org/), which needs a
working connection. If it is unavailable, use the prepared presenter laptop.
Browser participants should follow the projected local demonstration; do not
spend the live slot installing tools.

## Prepare before the event

Keep a local clone, the two [PDFs](../presentation/README.md), Python 3.11 or
newer, and the **Lean 4.28.0 toolchain** installed through `elan`. With a network
connection, an existing elan installation can fetch the pinned toolchain:

```bash
elan toolchain install leanprover/lean4:v4.28.0
./workshop browser check
```

The browser bundle imports only `Std`, supplied with Lean. It does not need
Mathlib, Lean Copilot, model weights, API keys, or third-party Python packages.

## Run without a connection

```bash
./workshop browser check
./workshop browser show 05
mkdir -p playground/current
cp course/browser/starters/05_AgentRepair.lean playground/current/Current.lean
./workshop browser check playground/current/Current.lean  # expected rfl rejection
# Replace only the final rfl proof with decide, then repeat:
./workshop browser check playground/current/Current.lean
```

Use an editor to show the theorem and diagnostic. The full bundle checker also
replays the rejection and checks all six completed proofs. A live AI service is
optional; a human can propose the same repair.

The separate shared-model Mathlib library can be built with `lake build` when its
dependencies are cached. It is not needed for this offline browser-task fallback.
