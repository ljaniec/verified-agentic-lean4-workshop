# Coding-Agent Entrypoints

> Optional local/extended material. For the current 45-minute event, follow
> the [browser task guide](../course/browser/README.md) and
> [supplied agenda](../presentation/workshop-agenda.pdf).

The repository keeps one canonical contract: `AGENTS.md`.

Thin compatibility entrypoints exist so common tools converge on that same
contract:

| Tool | Entrypoint |
|---|---|
| OpenAI Codex / AGENTS-aware tools | `AGENTS.md` |
| Claude Code | `CLAUDE.md` → `AGENTS.md` |
| Gemini / Antigravity | `GEMINI.md` → `AGENTS.md` |
| GitHub Copilot | `.github/copilot-instructions.md` → `AGENTS.md` |
| local OpenAI-compatible client | `./workshop task prompt` + local server |

The one-line participant instruction is:

```text
Follow AGENTS.md and WORKSHOP_TASK.md. Complete the current workshop task.
```

The repository supplies the allowed files, checker, stopping condition, and
branch transitions so the agent does not need a long custom prompt.
