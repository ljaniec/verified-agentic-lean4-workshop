.PHONY: verify verify-lean verify-python browser-check
verify:
	./workshop check
verify-lean:
	./workshop check --lean-only
verify-python:
	./scripts/verify_python.sh
browser-check:
	./workshop browser check
