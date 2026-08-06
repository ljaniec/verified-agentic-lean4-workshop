# Participant Guide

## Before the event

The recommended environments are Linux, macOS, or Windows through WSL 2.
Install Git, Git LFS, Lean through `elan`, Python 3.11 or 3.12, `uv`, and an
editor with the Lean 4 extension. Antigravity is recommended for the
agent-oriented part but is not required for the Lean-only path.

```bash
git clone <private-repository-url>
cd verified-agentic-lean4-workshop
./workshop setup
./workshop check
```

For Lean and Lean Copilot only:

```bash
./workshop setup --lean-only
./workshop check --lean-only
```

Run `./workshop doctor` when a prerequisite is missing. Copy `.env.example` to
`.env` only when a Gemini API key is available.

## During the workshop

List and load a scenario:

```bash
./workshop scenario list
./workshop scenario start lifecycle
./workshop scenario status
```

Edit both files:

```text
playground/current/Current.lean
playground/current/current.py
```

Check them together:

```bash
./workshop scenario check
```

The checker:

- rejects explicit proof holes and trust bypasses;
- treats Lean warnings as errors for the current exercise;
- compiles the exact Lean file;
- checks Python syntax and executes the Python exercise.

A failing Python assertion gives a concrete execution counterexample. A failing
Lean theorem shows that the universal claim is not yet proved. Generated model
or Lean Copilot output is only a candidate.

Useful Lean Copilot commands:

```lean
suggest_tactics
search_proof
select_premises
```

Reveal a reference solution only after attempting the exercise:

```bash
./workshop scenario solution lifecycle
./workshop scenario check
```

Your current pair is backed up automatically before another starter or solution
is loaded. Local copies are stored under `playground/backups/` and are not
committed.

Remove the current pair, while retaining a backup, with:

```bash
./workshop scenario clean
```

The workshop order is `lifecycle`, `bt`, `vda`, and `uncertainty`.
