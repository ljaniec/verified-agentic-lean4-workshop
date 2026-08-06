import shutil
import subprocess
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]


def run_scenario(root: Path, *arguments: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["bash", str(root / "scripts" / "scenario.sh"), *arguments],
        cwd=root,
        check=True,
        capture_output=True,
        text=True,
    )


def prepare_fixture(root: Path) -> None:
    (root / "scripts").mkdir(parents=True)
    shutil.copy2(REPOSITORY_ROOT / "scripts" / "common.sh", root / "scripts")
    shutil.copy2(REPOSITORY_ROOT / "scripts" / "scenario.sh", root / "scripts")

    lean_exercises = root / "exercises" / "lean"
    python_exercises = root / "exercises" / "python"
    lean_solutions = root / "VerifiedAgenticWorkshop" / "Solutions"
    python_solutions = root / "solutions" / "python"

    for directory in (
        lean_exercises,
        python_exercises,
        lean_solutions,
        python_solutions,
    ):
        directory.mkdir(parents=True)

    (lean_exercises / "01_LifecycleResources.lean.template").write_text(
        "starter Lean\n", encoding="utf-8"
    )
    (python_exercises / "01_lifecycle_resources.py.template").write_text(
        "print('starter Python')\n", encoding="utf-8"
    )
    (lean_solutions / "LifecycleResources.lean").write_text(
        "solution Lean\n", encoding="utf-8"
    )
    (python_solutions / "lifecycle_resources.py").write_text(
        "print('solution Python')\n", encoding="utf-8"
    )


def test_switching_to_solution_preserves_participant_work(tmp_path: Path) -> None:
    prepare_fixture(tmp_path)

    run_scenario(tmp_path, "start", "lifecycle")
    current = tmp_path / "playground" / "current"
    assert (current / "scenario").read_text(encoding="utf-8") == "lifecycle\n"
    assert (current / "source").read_text(encoding="utf-8") == "starter\n"

    (current / "Current.lean").write_text("participant work\n", encoding="utf-8")
    run_scenario(tmp_path, "solution", "lifecycle")

    backups = list((tmp_path / "playground" / "backups").iterdir())
    assert len(backups) == 1
    assert (backups[0] / "Current.lean").read_text(
        encoding="utf-8"
    ) == "participant work\n"
    assert (current / "source").read_text(
        encoding="utf-8"
    ) == "reference-solution\n"
    assert (current / "Current.lean").read_text(
        encoding="utf-8"
    ) == "solution Lean\n"

    status = run_scenario(tmp_path, "status")
    assert "Scenario: lifecycle" in status.stdout
    assert "Source:   reference-solution" in status.stdout
