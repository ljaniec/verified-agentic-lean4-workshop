# GitHub Copilot repository instructions

The canonical instructions are in `AGENTS.md`.

For the browser event, follow `course/browser/README.md`. A copied local snippet
is checked with `./workshop browser check playground/current/Current.lean`.

If `WORKSHOP_TASK.md` exists on a local checkpoint branch, read it and follow
the branch-aware workflow:

```bash
./workshop task status
./workshop task start
./workshop task check
```

Do not use a solution branch unless explicitly requested. Never bypass Lean
proof obligations.
