# Troubleshooting the current workshop

## The starter reports an error

Tasks 01–04 intentionally contain `skip` and report an unsolved goal. Task 05
intentionally rejects `rfl`. Replace only the final proof, then wait for checking
to finish and read All Messages. Do not use a proof bypass to hide an error.

## Missing definitions or duplicate declarations

Use the Raw view of the complete `.lean` file. Replace the previous editor
contents; do not paste only the last theorem or append tasks together.

## No goals at the cursor, but the file still has errors

Inspect All Messages, which covers the entire file. Acceptance requires no errors
or warnings after the checker finishes; the cursor's goal state alone is not enough.

## The browser or network is unavailable

Use the presenter's prepared [offline fallback](offline-mode.md). Do not start
installing packages during the event. A live AI model is optional.

## An older command or course link does not work

The current entry point is `./workshop browser`. Earlier branch courses and
model integrations were removed from `main`; their files remain in Git history.
`./workshop task check` remains an alias for the slide's local verification gate.

## Optional full local build needs dependencies

The browser bundle requires only the pinned Lean toolchain and Python. To build
the separate shared Mathlib library before the event, use `lake exe cache get`
and `lake build`. Do not attempt those downloads during the practical segment.
