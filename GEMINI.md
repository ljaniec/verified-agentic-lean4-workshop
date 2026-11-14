# Gemini / Antigravity entrypoint

Read and follow `AGENTS.md` as the canonical repository contract.

If `WORKSHOP_TASK.md` exists:

1. read it;
2. run `./workshop task status`;
3. run `./workshop task start`;
4. make only the smallest task-scoped edits;
5. run `./workshop task check` after each meaningful change;
6. stop at `WORKSHOP_TASK_OK`.

Do not inspect a `-solution` branch unless explicitly requested.

For the browser event, follow `course/browser/README.md`. A copied local snippet
is checked with `./workshop browser check playground/current/Current.lean`.
On `main`, follow the repository-maintenance scope in `AGENTS.md` when requested.

Gemini may propose, explain, and repair. It is not the proof authority. A Lean
claim is verified only when the local checker accepts the exact file.
