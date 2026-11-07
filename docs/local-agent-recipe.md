# Local Agent Recipe

The 45-minute workshop must not depend on a large GPU or on cloud access.

The recommended local runtime is **llama.cpp** because it supports CPU
inference, Apple Metal, NVIDIA CUDA, AMD HIP, Vulkan/SYCL backends, quantized
models, and an OpenAI-compatible local server.

## Profiles

### Tiny fallback

```bash
./workshop local-agent serve tiny
```

Model:

```text
ggml-org/Qwen3.5-0.8B-GGUF:Q4_0
```

The Q4 model file is roughly 0.6 GB. Runtime memory is higher because the model
also needs context/KV/cache memory. Use this profile for task navigation,
explanations, and very small edits. Do not expect a 0.8B model to solve every
Lean proof.

### Standard laptop

```bash
./workshop local-agent serve standard
```

Model:

```text
Qwen/Qwen3-4B-GGUF:Q4_K_M
```

The Q4_K_M model file is roughly 2.5 GB. It is suitable for a laptop with
several GB of free RAM; GPU offload is optional. This is the preferred local
coding/tutor profile when the machine can afford it.

## Install llama.cpp before the event

Use an official/prebuilt installation appropriate for the operating system.
Current llama.cpp provides prebuilt binaries and package-manager options, and
can also be built from source.

Check:

```bash
./workshop local-agent doctor
```

## Prefetch during preparation

```bash
./workshop prepare --local-agent tiny
# or
./workshop prepare --local-agent standard
```

Do **not** make participants download model weights during the 45-minute
session.

## OpenAI-compatible endpoint

The launcher binds only to loopback:

```text
http://127.0.0.1:8080/v1
```

This endpoint can be used by an OpenAI-compatible local coding client. The
repository-level behavior is defined by `AGENTS.md` and the current
`WORKSHOP_TASK.md`, not by a model-specific system prompt.

Get the task prompt with:

```bash
./workshop task prompt
```

## Lean-specific optional model

For experimentation outside the critical workshop path,
`AI-MO/Kimina-Prover-RL-0.6B` is a small Lean-specialized model. Its published
safetensors are about 1.5 GB. It is deliberately **not** a default participant
dependency because it adds a second inference stack and setup risk.

## Trust rule

Local does not mean trusted.

A small local model may hallucinate declarations or produce invalid tactics.
Its candidate must pass exactly the same:

```bash
./workshop task check
```

gate as a candidate from Gemini, Codex, Claude, Lean Copilot, or a human.
