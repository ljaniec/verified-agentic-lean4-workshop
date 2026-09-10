from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
CURRICULUM = REPOSITORY_ROOT / "curriculum"

EXPECTED_STAGES = {
    "00-setup-and-trust-boundary",
    "01-lifecycle-resources",
    "02-behavior-tree-refinement",
    "03-vda5050-demo",
    "04-uncertainty-demo",
    "05-gemini-verification-demo",
    "06-wrap-up",
}

EXPECTED_TASKS = {
    "00-setup-and-trust-boundary/01-preflight",
    "00-setup-and-trust-boundary/02-trust-boundary",
    "01-lifecycle-resources/01-reproduce-the-bug",
    "01-lifecycle-resources/02-read-the-invariant",
    "01-lifecycle-resources/03-repair-the-python-transition",
    "01-lifecycle-resources/04-check-the-finite-state-space",
    "01-lifecycle-resources/05-prove-one-step-preservation",
    "01-lifecycle-resources/06-lift-to-finite-traces",
    "02-behavior-tree-refinement/01-read-the-reference-policy",
    "02-behavior-tree-refinement/02-find-the-counterexample",
    "02-behavior-tree-refinement/03-repair-the-fsm",
    "02-behavior-tree-refinement/04-prove-pointwise-refinement",
    "02-behavior-tree-refinement/05-lift-refinement-to-traces",
    "03-vda5050-demo/01-structural-vs-temporal-validity",
    "03-vda5050-demo/02-diagnose-the-first-invalid-event",
    "03-vda5050-demo/03-connect-monitor-to-a-formal-claim",
    "04-uncertainty-demo/01-show-the-point-estimate-failure",
    "04-uncertainty-demo/02-switch-to-a-set-valued-contract",
    "04-uncertainty-demo/03-show-the-universal-lean-claim",
    "05-gemini-verification-demo/01-make-the-tool-boundary-visible",
    "05-gemini-verification-demo/02-submit-a-candidate-and-observe-rejection",
    "05-gemini-verification-demo/03-repair-and-verify",
}


def test_reference_solution_directories_are_absent() -> None:
    assert not (REPOSITORY_ROOT / "VerifiedAgenticWorkshop" / "Solutions").exists()
    assert not (REPOSITORY_ROOT / "solutions").exists()


def test_participant_curriculum_contains_no_answer_notes() -> None:
    leaked = sorted(CURRICULUM.rglob("SOLUTION.md"))
    leaked.extend(sorted(CURRICULUM.rglob("FACILITATOR.md")))
    assert not leaked, f"answer material leaked onto participant branch: {leaked}"


def test_participant_scenario_cli_does_not_reveal_answers() -> None:
    script = (REPOSITORY_ROOT / "scripts" / "scenario.sh").read_text(
        encoding="utf-8"
    )

    assert "solution)" not in script
    assert "verify-solutions" not in script
    assert "load_solution" not in script


def test_numbered_curriculum_is_complete() -> None:
    assert CURRICULUM.is_dir()
    actual_stages = {path.name for path in CURRICULUM.iterdir() if path.is_dir()}
    assert EXPECTED_STAGES <= actual_stages

    missing_readmes = [
        task for task in sorted(EXPECTED_TASKS) if not (CURRICULUM / task / "README.md").is_file()
    ]
    assert not missing_readmes, f"missing task README files: {missing_readmes}"


def test_optional_stretch_theorems_do_not_block_baseline_starters() -> None:
    lifecycle = (
        REPOSITORY_ROOT / "exercises" / "lean" / "01_LifecycleResources.lean.template"
    ).read_text(encoding="utf-8")
    behavior_tree = (
        REPOSITORY_ROOT
        / "exercises"
        / "lean"
        / "02_BehaviorTreeRefinement.lean.template"
    ).read_text(encoding="utf-8")

    assert "theorem run_preserves_safety" not in lifecycle
    assert "theorem corrected_fsm_trace_matches_bt" not in behavior_tree
