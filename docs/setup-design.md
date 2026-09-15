# Setup Design

The repository deliberately follows the conventional shape of a small Lake
project rather than introducing a workshop-specific build system:

```text
lean-toolchain
lakefile.toml
lake-manifest.json
VerifiedAgenticWorkshop.lean
VerifiedAgenticWorkshop/
```

This is the same basic shape expected by Lake, Mathlib-based projects, Lean
Copilot, LeanDojo tooling, and Aristotle's `--project-dir` workflow. The
workshop adds only one thin command dispatcher, `./workshop`, around standard
commands.

## Design goals

1. **One participant command.** `./workshop setup` prepares the complete
   environment; `./workshop setup --lean-only` omits Google ADK.
2. **Pinned Lean dependencies.** `lean-toolchain`, `lakefile.toml`, and the
   generated `lake-manifest.json` define the exact Lean environment.
3. **Binary caches before compilation.** Setup runs `lake exe cache get` before
   `lake build` to avoid rebuilding Mathlib locally.
4. **Lean first, agents optional.** Python and cloud credentials are not needed
   for the core exercises or Lean Copilot.
5. **No custom proof protocol.** Lean Copilot is used through its native
   `suggest_tactics`, `search_proof`, and `select_premises` commands.
6. **Standard Aristotle submission.** `./workshop aristotle` submits the whole
   Lake project without repackaging its sources.
7. **No hosted CI dependency.** `./workshop check` is the reproducible local
   acceptance gate.

## Lockfiles

The first successful native setup creates `lake-manifest.json`; the first full
agent setup creates `uv.lock`. Both files should be reviewed and committed so
participants receive an identical dependency graph. Setup does not run
`lake update` when a manifest is already present.

## LeanDojo scope

LeanDojo itself is not a runtime dependency of the workshop. Lean Copilot
already supplies the participant-facing model integration. LeanDojo should be
added only for a later, separate track involving trace extraction, premise
index construction, or prover evaluation; adding it to every participant's
setup would increase download time and failure modes without improving the
core exercise.

## Supported participant environment

Linux, macOS, and Windows through WSL 2 are the primary targets. Native Windows
may work, but WSL 2 gives the most uniform shell, linker, and CTranslate2
behavior for a room-scale workshop.
