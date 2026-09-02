# Agent Instructions — Reference Solutions Overlay

This branch adds facilitator/reference answers on top of the participant branch.

## Non-negotiable rules

- Write all content in English.
- Never add GitHub Actions workflows.
- Never use `sorry`, `admit`, new axioms, `native_decide`, `implemented_by`, or
  another proof bypass in a reference answer.
- Never claim a reference proof is verified until the pinned Lean toolchain
  compiles it.
- Never commit API keys, model credentials, downloaded weights, or participant
  data.

## Overlay policy

- Shared models, starter exercises, curriculum structure, and common tooling
  must be changed on `agent/initial-workshop-platform` first.
- Keep this branch limited to completed answers, answer validation, and
  facilitator-specific notes/commands.
- Do not merge this branch into the participant branch.
- When participant models change, update/rebase this overlay and re-run all
  reference validation before the workshop.
- A branch is not an access-control boundary; keep this overlay private or
  unpublished if answers must remain hidden while the participant repository is
  public.

## Validation

```bash
./workshop check
./workshop scenario verify-solutions
```

Then load and check every reference scenario.
