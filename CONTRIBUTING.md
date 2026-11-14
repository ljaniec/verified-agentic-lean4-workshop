# Contributing

This branch contains the current checked browser workshop. Earlier courses are
retained in Git history, not in the participant file tree.

1. Make focused changes on a branch and prepare a draft pull request.
2. Preserve the shared model and theorem statements.
3. Run `./workshop browser check` after task/export changes.
4. Run `./workshop check` for the full pinned Lean and Python acceptance checks.
5. Check documentation links and visually inspect any changed PDF pages.

GitHub Actions are intentionally disabled. For development tools, run
`uv sync --group dev --locked`. Browser participants need no local setup.
The optional full library build uses the pinned Mathlib dependency; the browser
bundle and its offline checker use only core Lean/Std.
