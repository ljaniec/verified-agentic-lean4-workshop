# Troubleshooting

For exercise-specific failures, also see
[`participant-debugging.md`](participant-debugging.md).

## `git-lfs` is missing

Install Git LFS, rerun `git lfs install`, then rerun `./workshop setup`.

## Mathlib starts compiling from source

Run `lake exe cache get`. If the cache is inconsistent, remove `.lake` and rerun
setup. This may redownload dependencies, so do not do it during the live session
unless the facilitator asks you to.

## Lean Copilot cannot find its models

Run:

```bash
lake exe LeanCopilot/download
```

Verify that the user cache directory is writable. During the event, prefer a
prepared local cache rather than depending on a large live download.

## `-lctranslate2` cannot be linked

Ensure setup completed for Lean Copilot. On native Windows, use the
platform-specific Lean Copilot linker guidance; WSL 2 is the preferred workshop
fallback for a mixed environment.

## `./workshop scenario check` fails while I am only halfway through a task

The full scenario checker validates the entire active Lean/Python pair. During
an intermediate Lean checkpoint, a later required TODO may still be unfinished.
Use the Lean editor goal/error state for the theorem you are currently solving
and run the full scenario check after the required baseline tasks are complete.

The optional finite-trace stretch theorems are not predeclared in the baseline
starter, so skipping them does not block the required check.

## ADK cannot find the agent

Run from the repository root:

```bash
./workshop agent-web
```

or, when debugging the ADK command directly:

```bash
uv run adk web agents
```

The `agents/verified_lean_tutor/` directory must contain `__init__.py` and
`agent.py`, and `agent.py` must export `root_agent`.

## The Gemini agent stops with `GOOGLE_MODEL is not configured`

This is intentional. The repository does not silently select a possibly stale
model for the live event. Copy `.env.example` to `.env` and set both:

```text
GOOGLE_API_KEY=...
GOOGLE_MODEL=<tested-event-model>
```

only after the facilitator has selected and rehearsed the exact event
configuration.

## A model says the proof is complete, but Lean fails

The candidate is not verified. Read the exact Lean diagnostic, repair the
source, and run the checker again. Never weaken the gate by inserting a proof
hole or unchecked assumption.

## I started the next scenario and lost my previous files

The scenario loader backs up the active pair before replacing it. Look under:

```text
playground/backups/
```

and follow [`../curriculum/CATCH_UP.md`](../curriculum/CATCH_UP.md).
