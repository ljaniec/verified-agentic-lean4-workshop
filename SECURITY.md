# Security notes

This is educational software, not a multi-tenant proof service. The browser
workshop requires no API keys, cloud credentials, or local model service.

- The checker rejects explicit proof bypasses and treats Lean warnings as errors.
- Local compilation has a timeout. Compile only code you are prepared to run.
- Lean elaboration can execute metaprogramming from imported packages.
- Keep participant work and generated diagnostics in ignored runtime directories.
- A checked theorem establishes its explicit claim under the model's assumptions.
