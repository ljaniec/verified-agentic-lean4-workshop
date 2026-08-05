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

## Project conventions

- Preserve the standard Lake project shape so Lean Copilot, LeanDojo tooling,
  and Aristotle can operate on the repository without repackaging.
- Keep the Lean-only path independent of Python, Gemini, and Google ADK.
- Treat `lake-manifest.json` and `uv.lock` as reproducibility artifacts once
  generated on the reference machine.

## Validation

Run:

```bash
./workshop check
```

When dependencies are not installed, run `./workshop setup` first.
