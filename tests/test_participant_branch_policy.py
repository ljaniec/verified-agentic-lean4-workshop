from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]


def test_reference_solution_directories_are_absent() -> None:
    assert not (REPOSITORY_ROOT / "VerifiedAgenticWorkshop" / "Solutions").exists()
    assert not (REPOSITORY_ROOT / "solutions").exists()


def test_participant_scenario_cli_does_not_reveal_answers() -> None:
    script = (REPOSITORY_ROOT / "scripts" / "scenario.sh").read_text(
        encoding="utf-8"
    )

    assert "solution)" not in script
    assert "verify-solutions" not in script
    assert "load_solution" not in script


def test_numbered_curriculum_is_present() -> None:
    curriculum = REPOSITORY_ROOT / "curriculum"
    expected_stages = {
        "00-setup-and-trust-boundary",
        "01-lifecycle-resources",
        "02-behavior-tree-refinement",
        "03-vda5050-demo",
        "04-uncertainty-demo",
        "05-gemini-verification-demo",
        "06-wrap-up",
    }

    assert curriculum.is_dir()
    assert expected_stages <= {path.name for path in curriculum.iterdir() if path.is_dir()}
