# Demo 05.1 — Make the Tool Boundary Visible

**Target time:** 3 minutes

## Objective

Show that the AI model and the verifier are different components with different
authority.

## Facilitator action

Display the constrained tools available to the agent. The exact names may evolve
while the integration is finalized, but the capabilities should stay narrow:

```text
read allowed workshop source
scan a Lean file
compile/check a Lean file
return verifier output
```

The agent should not receive unrestricted shell access merely to make the demo
convenient.

## Explain

Gemini may choose or request an allowed tool operation, but the application
executes the operation and Lean determines whether the proof checks.

## Ask the room

Which component is allowed to say "verified"?

Correct answer: the surrounding application may report that status only after
the Lean checker succeeds; the model's own prose is not sufficient.

## Fallback

If the live Gemini integration is unavailable, show the same boundary using the
local constrained checker already present in the repository.

## Done when

Participants can identify the model, tool/orchestration layer, and Lean verifier
as separate trust domains.
