# Demo 05.2 — Submit a Candidate and Observe Rejection

**Target time:** 4 minutes

## Objective

Make an AI failure useful and visible rather than hiding it.

## Preferred live path

Ask Gemini for a Lean proof or repair of a deliberately selected workshop goal.
Submit the returned candidate through the constrained checker.

For a robust live demo, prepare a goal for which at least one plausible but
incorrect candidate is known in advance. Do not rely on the model spontaneously
failing in exactly the desired way.

## Observe

The checker should return a concrete Lean error or unsuccessful verification
status. Show that feedback to the audience before asking Gemini to repair the
candidate.

## Fallback path

If the API/network path is unavailable:

1. paste the prepared invalid candidate into the demonstration file;
2. run the local checker;
3. show the same Lean diagnostic;
4. continue to the repair step.

## Ask the room

Did the failed candidate make Gemini useless?

No. The verifier converted an unreliable proposal into structured feedback that
can drive the next attempt.

## Done when

The audience has seen a plausible candidate rejected by Lean and understands
that rejection is a successful operation of the system, not a broken demo.
