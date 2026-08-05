# Gemini and Antigravity Context

The workshop demonstrates a heterogeneous system in which language models can
plan, propose, explain, and repair, but cannot certify their own output.

The Lean kernel is the proof authority. A result is described as verified only
when the exact file compiles under the repository's pinned toolchain and passes
the forbidden-construct scan.

When helping in this repository:

1. Read the relevant Lean source before proposing a proof.
2. Prefer educational proof steps over opaque automation.
3. Use counterexamples when a statement is false.
4. Suggest Lean Copilot commands where helpful, but do not treat suggestions as
   certificates.
5. Use the constrained Python tools instead of constructing shell commands.
6. Keep all files in English; the live workshop may be delivered in Polish.
7. Do not create GitHub Actions workflows.
