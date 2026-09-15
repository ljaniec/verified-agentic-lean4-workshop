# Contributing

The repository is private during workshop development. Every substantive
change should be made on a branch and proposed through a draft pull request.

## Development flow

1. Run `./workshop doctor` when preparing a new machine.
2. Run `./workshop setup` on the first checkout.
3. Make one focused change.
4. Run `./workshop check` locally.
5. Open a draft pull request with the local validation results.

Use `--lean-only` for changes that do not touch the optional Google ADK/Python
layer. GitHub Actions are intentionally disabled and must not be added.
