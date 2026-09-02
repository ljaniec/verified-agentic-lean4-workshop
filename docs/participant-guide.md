# Participant Guide

## Before the event

The recommended environments are Linux, macOS, or Windows through WSL 2.
Install Git, Git LFS, Lean through `elan`, Python 3.11 or 3.12, `uv`, and an
editor with the Lean 4 extension. Antigravity may be used for the agent-oriented
part but is not required for the Lean-only path.

```bash
git clone <repository-url>
cd verified-agentic-lean4-workshop
./workshop setup
./workshop check
```

For Lean and Lean Copilot only:

```bash
./workshop setup --lean-only
./workshop check --lean-only
```

Run `./workshop doctor` when a prerequisite is missing. Configure Gemini only
when the facilitator confirms that the tested API/agent path is being used.

## During the workshop

Follow the numbered instructions in:

```text
curriculum/
```

Start at [`curriculum/README.md`](../curriculum/README.md). Each task has its own
folder with commands, objective, hints, completion criteria, and recovery path.

Load a starter scenario with:

```bash
./workshop scenario list
./workshop scenario start lifecycle
./workshop scenario status
```

Edit:

```text
playground/current/Current.lean
playground/current/current.py
```

Check the active pair:

```bash
./workshop scenario check
```

The checker:

- rejects explicit proof holes and unchecked assumption declarations used as
  workshop bypasses;
- treats Lean warnings as errors for the current exercise;
- compiles the exact Lean file;
- checks Python syntax and executes the Python exercise.

A failing Python assertion can expose a concrete execution problem. A failing
Lean theorem means the formal claim is not yet proved. Generated model or Lean
Copilot output remains a candidate until the checker accepts it.

Useful Lean Copilot commands include:

```lean
suggest_tactics
search_proof
select_premises
```

## Falling behind is expected and recoverable

The workshop does **not** require every participant to finish every stretch
proof. The lifecycle trace proof and BT trace-refinement proof are explicitly
optional when time is tight. Later demos do not depend on your local exercise
being complete.

When switching to another starter, your current Lean/Python pair is backed up
automatically under:

```text
playground/backups/
```

You can therefore move with the room and return to unfinished work later.

## Reference solutions

Completed answers are intentionally absent from the participant branch. They
are maintained separately for facilitator preparation and post-workshop study,
so an accidental command cannot replace your work with the answer during the
session.

A separate Git branch is not a security boundary. If the repository is public,
reference answers should be published only after the live workshop if they need
to remain unavailable during the event.

## Clean the active workspace

```bash
./workshop scenario clean
```

The current pair is backed up before removal.
