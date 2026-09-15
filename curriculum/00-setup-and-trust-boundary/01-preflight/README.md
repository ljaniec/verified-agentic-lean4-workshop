# Task 00.1 — Preflight

**Target time:** 4 minutes

## Objective

Confirm that the pinned workshop environment is available and load the first
exercise without changing any code.

## Run

```bash
./workshop doctor
./workshop check
./workshop scenario start lifecycle
./workshop scenario status
```

## Observe

The status command should point to:

```text
playground/current/Current.lean
playground/current/current.py
```

The starter is intentionally incomplete. A later `scenario check` may fail
until you complete its tasks.

## Do not do

Do not change dependency versions during the workshop and do not install
additional theorem-proving stacks unless the facilitator asks you to.

## Done when

- `doctor` reports the required tools as available;
- the `lifecycle` scenario is active;
- you know which two files you will edit.

## Recovery

If the full environment fails but Lean is available, run:

```bash
./workshop doctor --lean-only
./workshop check --lean-only
```

Tell the facilitator which command failed; do not spend workshop time debugging
an unrelated package-manager issue alone.
