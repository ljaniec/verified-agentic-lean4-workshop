# Stage 00 — Setup and Trust Boundary

**Time:** 0–10 minutes  
**Mode:** facilitator-guided  
**Required:** yes

This stage establishes the workshop contract before any theorem proving starts.
You will verify that the local toolchain works and distinguish an AI proposal
from a checked Lean result.

## Tasks

1. [`01-preflight`](01-preflight/README.md) — confirm the environment and load the first scenario.
2. [`02-trust-boundary`](02-trust-boundary/README.md) — see what counts as a proposal and what counts as verification.

## Done when

You can run `./workshop scenario status`, identify the active Lean and Python
files, and explain why a generated proof is not accepted until Lean checks it.
