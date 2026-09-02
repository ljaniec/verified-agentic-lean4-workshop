# Agent Instructions

This repository teaches a strict trust boundary for AI-assisted formalization.

## Non-negotiable rules

- Write all repository content in English.
- Never add GitHub Actions workflows. Validation is local and is run with
  `./workshop check`.
- Never add `sorry`, `admit`, new axioms, `native_decide`, `implemented_by`, or
  another mechanism that bypasses the intended proof obligation.
- Never claim that generated Lean code is verified until the pinned Lean
  toolchain compiles it.
- Keep agent tools narrow. Do not expose a general shell command to an LLM.
- Never commit API keys, tokens, downloaded model weights, or participant data.
- Prefer small, reviewable changes and open a draft pull request. Do not merge
  changes automatically.

## Participant/reference branch policy

The branch used by PR #1 (`agent/initial-workshop-platform`) is the participant
branch.

- Do **not** add completed exercise proofs, completed Python answers, answer
  keys, or a command that reveals them on this branch.
- Participant instructions belong under `curriculum/`, with one folder per
  stage and one subfolder per concrete task/demo step.
- Reference solutions are maintained separately on
  `workshop/reference-solutions` for facilitator preparation and post-workshop
  release.
- A branch is not an access-control boundary. If the main repository becomes
  public before the event, keep unpublished answers in a private repository or
  publish the solution branch only after the session.
- Do not merge the solution branch into the participant branch.

## Project conventions

- Preserve the standard Lake project shape so Lean Copilot, LeanDojo tooling,
  and Aristotle can operate on the repository without repackaging.
- Keep the Lean-only path independent of Python, Gemini, and Google ADK.
- Treat `lake-manifest.json` and `uv.lock` as reproducibility artifacts once
  generated on the reference machine.
- Keep the live Google/Gemini path outside the critical workshop path until it
  has passed an end-to-end rehearsal; preserve a deterministic local fallback.

## Validation

Run:

```bash
./workshop check
```

When dependencies are not installed, run `./workshop setup` first.
