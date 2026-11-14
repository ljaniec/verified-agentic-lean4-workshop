import subprocess
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]


@pytest.mark.parametrize(
    ("source", "accepted"),
    [
        ("example : 1 = 1 := by rfl\n", True),
        ("example : 1 = 2 := by rfl\n", False),
    ],
)
def test_candidate_check_uses_real_lean_from_another_directory(
    tmp_path: Path, source: str, accepted: bool
) -> None:
    candidate = tmp_path / "Candidate.lean"
    candidate.write_text(source)
    result = subprocess.run(
        [str(ROOT / "workshop"), "browser", "check", str(candidate)],
        cwd=tmp_path,
        capture_output=True,
        text=True,
        timeout=30,
        check=False,
    )
    assert (result.returncode == 0) == accepted
    assert ("BROWSER_FILE_OK" in result.stdout) == accepted
    if not accepted:
        assert "rfl" in result.stdout
        assert "Candidate rejected by Lean" in result.stderr


def test_missing_candidate_cannot_report_success(tmp_path: Path) -> None:
    result = subprocess.run(
        [str(ROOT / "workshop"), "browser", "check", str(tmp_path / "Absent.lean")],
        capture_output=True,
        text=True,
        timeout=30,
        check=False,
    )
    assert result.returncode != 0
    assert "BROWSER_FILE_OK" not in result.stdout


def test_unknown_task_is_an_error() -> None:
    result = subprocess.run(
        [str(ROOT / "workshop"), "browser", "show", "99"],
        capture_output=True,
        text=True,
        timeout=30,
        check=False,
    )
    assert result.returncode != 0
    assert "invalid choice" in result.stderr
