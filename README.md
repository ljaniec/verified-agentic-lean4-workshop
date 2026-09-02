# From Hallucination to Proof — Reference Solutions

**Facilitator and post-workshop overlay for the verified robotics workshop.**

This branch is built directly on top of the current participant branch and adds
completed Lean proofs, completed Python implementations, task-level solution
notes, and facilitator demo notes.

Start with:

**[`REFERENCE_SOLUTIONS.md`](REFERENCE_SOLUTIONS.md)**

## Validate this branch

```bash
./workshop setup
./workshop check
./workshop scenario verify-solutions
```

Then validate each loaded answer:

```bash
for scenario in lifecycle bt vda uncertainty; do
  ./workshop scenario solution "$scenario"
  ./workshop scenario check
done
```

## Branch discipline

Shared workshop changes belong on `agent/initial-workshop-platform` first. Keep
this branch as a small answer overlay so reference proofs cannot silently drift
from participant models and instructions.

Do not use this branch as the live participant checkout. Prefer a separate Git
worktree for facilitator preparation and demos.

A Git branch is not access control. If the main repository is published before
the event and answers must remain hidden, keep this overlay private/unpublished
until the workshop ends.

GitHub Actions remain disabled; all validation is local.
