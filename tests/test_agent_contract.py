from __future__ import annotations


def test_agent_module_exposes_root_agent() -> None:
    from agents.verified_lean_tutor.agent import root_agent

    assert root_agent.name == "verified_lean_tutor"
    assert "Lean 4" in root_agent.description
