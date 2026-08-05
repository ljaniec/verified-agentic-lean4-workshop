.PHONY: setup setup-lean setup-fast doctor verify verify-lean verify-python agent agent-web reset aristotle

setup:
	./workshop setup

setup-lean:
	./workshop setup --lean-only

setup-fast:
	./workshop setup --lean-only --skip-models

doctor:
	./workshop doctor

verify:
	./workshop check

verify-lean:
	./workshop check --lean-only

verify-python:
	./scripts/verify_python.sh

agent:
	./workshop agent

agent-web:
	./workshop agent-web

reset:
	./workshop reset

aristotle:
	./workshop aristotle
