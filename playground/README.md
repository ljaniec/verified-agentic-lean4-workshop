# Participant Playground

The workshop loader places the active exercise pair under:

```text
playground/current/Current.lean
playground/current/current.py
```

`playground/current/` and `playground/backups/` are local runtime directories
and are ignored by Git. Do not commit completed participant exercises here.

Load a starter with:

```bash
./workshop scenario start lifecycle
```

Inspect the active scenario with:

```bash
./workshop scenario status
```

Run the complete baseline check only after the required TODOs for that scenario
are finished:

```bash
./workshop scenario check
```

Starting another scenario automatically backs up the current pair first.
Reference answers are intentionally absent from the participant branch.
