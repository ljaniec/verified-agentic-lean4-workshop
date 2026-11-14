from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TABLE = ROOT / "course" / "45min" / "tasks.tsv"


def _rows() -> list[list[str]]:
    return [
        line.split("|")
        for line in TABLE.read_text(encoding="utf-8").splitlines()
        if line and not line.startswith("#")
    ]


def test_45min_course_has_unique_checkpoint_pairs() -> None:
    rows = _rows()
    assert [row[0] for row in rows] == [
        "00-build",
        "01-lifecycle",
        "02-bt-refinement",
        "03-vda-trace",
        "04-uncertainty",
        "05-agent-loop",
    ]
    task_branches = [row[2] for row in rows]
    solution_branches = [row[3] for row in rows]
    assert len(task_branches) == len(set(task_branches))
    assert len(solution_branches) == len(set(solution_branches))
    assert not set(task_branches) & set(solution_branches)


def test_checkpoint_chain_points_to_next_task() -> None:
    rows = _rows()
    for current, following in zip(rows, rows[1:], strict=False):
        assert current[4] == following[2]
    assert rows[-1][4] == ""


def test_live_task_timeboxes_leave_wrapup_time() -> None:
    total = sum(int(row[5]) for row in _rows())
    assert total == 42
    assert total < 45


def test_agent_repair_scenario_is_registered() -> None:
    scenario = (ROOT / "scripts" / "scenario.sh").read_text(encoding="utf-8")
    assert 'agent)' in scenario
    assert 'LEAN_STEM="05_AgentRepair"' in scenario
    assert 'PYTHON_STEM="05_agent_repair"' in scenario


def test_agent_entrypoints_delegate_to_agents_md() -> None:
    assert "AGENTS.md" in (ROOT / "CLAUDE.md").read_text(encoding="utf-8")
    assert "AGENTS.md" in (ROOT / "GEMINI.md").read_text(encoding="utf-8")
    assert "AGENTS.md" in (
        ROOT / ".github" / "copilot-instructions.md"
    ).read_text(encoding="utf-8")
