# Offline-First Operation

The local path requires no Gemini key after dependencies and models have been
prefetched.

Before the event, run on every prepared laptop:

```bash
./scripts/setup.sh
./scripts/verify.sh
```

The facilitator should also keep backups of:

- the repository clone;
- the `.lake` dependency and Mathlib cache state;
- the Lean Copilot model cache under the user cache directory;
- the `uv` download cache;
- a known-good PDF or screen recording of the ADK demonstration.

Do not copy personal API keys into the backup image.
