from __future__ import annotations

import pytest


def test_agent_module_exposes_root_agent(monkeypatch: pytest.MonkeyPatch) -> None:
    # Validate the tool contract without requiring event credentials or a model call.
    monkeypatch.setenv("GOOGLE_MODEL", "test-model-no-network")
    from agents.verified_lean_tutor.agent import root_agent

    assert root_agent.name == "verified_lean_tutor"
    assert "Lean 4" in root_agent.description
