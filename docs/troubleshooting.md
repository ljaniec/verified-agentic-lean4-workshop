# Troubleshooting

## `git-lfs` is missing

Install Git LFS, rerun `git lfs install`, then rerun `./scripts/setup.sh`.

## Mathlib starts compiling from source

Run `lake exe cache get`. If the cache is inconsistent, remove `.lake` and rerun
setup. This may redownload dependencies.

## Lean Copilot cannot find its models

Run `lake exe LeanCopilot/download`. Verify that the user cache directory is
writable and that the event network allows the download.

## `-lctranslate2` cannot be linked

Ensure setup completed for Lean Copilot. On native Windows, follow Lean
Copilot's platform-specific library-path instructions. WSL is the preferred
fallback for a mixed workshop environment.

## ADK cannot find the agent

Run the web interface from the repository root with:

```bash
uv run adk web agents
```

The directory must contain `verified_lean_tutor/__init__.py` and `agent.py`, and
`agent.py` must export `root_agent`.

## A model says the proof is complete, but Lean fails

The model is wrong. Read the exact compiler diagnostic, repair the source, and
run the checker again. Never weaken the gate by inserting `sorry`.
