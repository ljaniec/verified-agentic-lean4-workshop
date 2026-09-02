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
    lean_exercises.mkdir(parents=True)
    python_exercises.mkdir(parents=True)

    (lean_exercises / "01_LifecycleResources.lean.template").write_text(
        "lifecycle starter Lean\n", encoding="utf-8"
    )
    (python_exercises / "01_lifecycle_resources.py.template").write_text(
        "print('lifecycle starter Python')\n", encoding="utf-8"
    )
    (lean_exercises / "02_BehaviorTreeRefinement.lean.template").write_text(
        "bt starter Lean\n", encoding="utf-8"
    )
    (python_exercises / "02_behavior_tree_refinement.py.template").write_text(
        "print('bt starter Python')\n", encoding="utf-8"
    )


def test_switching_scenarios_preserves_participant_work(tmp_path: Path) -> None:
    prepare_fixture(tmp_path)

    run_scenario(tmp_path, "start", "lifecycle")
    current = tmp_path / "playground" / "current"
    assert (current / "scenario").read_text(encoding="utf-8") == "lifecycle\n"
    assert (current / "source").read_text(encoding="utf-8") == "starter\n"

    (current / "Current.lean").write_text("participant work\n", encoding="utf-8")
    run_scenario(tmp_path, "start", "bt")

    backups = list((tmp_path / "playground" / "backups").iterdir())
    assert len(backups) == 1
    assert (backups[0] / "Current.lean").read_text(
        encoding="utf-8"
    ) == "participant work\n"
    assert (current / "scenario").read_text(encoding="utf-8") == "bt\n"
    assert (current / "source").read_text(encoding="utf-8") == "starter\n"
    assert (current / "Current.lean").read_text(
        encoding="utf-8"
    ) == "bt starter Lean\n"

    status = run_scenario(tmp_path, "status")
    assert "Scenario: bt" in status.stdout
    assert "Source:   starter" in status.stdout


def test_tampered_metadata_cannot_escape_backup_root(tmp_path: Path) -> None:
    prepare_fixture(tmp_path)
    run_scenario(tmp_path, "start", "lifecycle")

    current = tmp_path / "playground" / "current"
    (current / "Current.lean").write_text("participant work\n", encoding="utf-8")
    (current / "scenario").write_text("../../../outside\n", encoding="utf-8")
    (current / "source").write_text("../../tampered\n", encoding="utf-8")

    run_scenario(tmp_path, "start", "bt")

    backup_root = tmp_path / "playground" / "backups"
    backups = list(backup_root.iterdir())
    assert len(backups) == 1
    assert "-unknown-unknown-" in backups[0].name
    assert backups[0].parent == backup_root
    assert (backups[0] / "Current.lean").read_text(
        encoding="utf-8"
    ) == "participant work\n"
    assert not any(path.name.startswith("outside") for path in tmp_path.iterdir())
