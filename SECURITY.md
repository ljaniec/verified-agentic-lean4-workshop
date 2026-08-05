# Security Notes

This is educational software, not a hardened multi-tenant proof service.

- The ADK agent receives no arbitrary shell tool.
- Lean file access is restricted to workshop directories and checked against
  path traversal.
- Compilation has a timeout and output limit.
- API keys belong only in the untracked `.env` file.
- Do not expose the local ADK or Lean service directly to the public Internet.
- For an event network, place any shared model endpoint behind an authenticated,
  rate-limited reverse proxy and isolate participant workspaces.
- Lean elaboration can execute trusted metaprogramming from imported packages;
  compile only workshop code and code you are prepared to run locally.
