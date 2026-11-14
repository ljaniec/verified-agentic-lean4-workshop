import shutil
import subprocess
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]


def prepare_scanner(root: Path) -> Path:
    scripts = root / "scripts"
    scripts.mkdir(parents=True)
    shutil.copy2(REPOSITORY_ROOT / "scripts" / "common.sh", scripts)
    shutil.copy2(
        REPOSITORY_ROOT / "scripts" / "check_forbidden_constructs.sh",
        scripts,
    )
    return scripts / "check_forbidden_constructs.sh"


def run_scanner(
    root: Path, scanner: Path, *lean_files: Path
) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["bash", str(scanner), *(str(path) for path in lean_files)],
        cwd=root,
        check=False,
        capture_output=True,
        text=True,
    )


def test_scanner_distinguishes_prose_from_proof_holes(tmp_path: Path) -> None:
    scanner = prepare_scanner(tmp_path)

    valid = tmp_path / "Valid.lean"
    valid.write_text(
        "-- Do not use `sorry`, `axiom`, or `constant` in this exercise.\n"
        "/- Nested comment mentioning sorry. /- constant x : False -/ -/\n"
        '#eval "sorry is text here"\n'
        "example : True := by trivial\n",
        encoding="utf-8",
    )
    accepted = run_scanner(tmp_path, scanner, valid)
    assert accepted.returncode == 0

    forbidden_sources = {
        "ParenSorry.lean": "example : True := (by sorry)\n",
        "SorryAx.lean": "example : False := Lean.sorryAx False true\n",
        "Constant.lean": "constant fabricated : False\n",
        "Axiom.lean": "axiom fabricated : False\n",
        "NativeDecide.lean": "example : True := by native_decide\n",
    }

    for filename, source in forbidden_sources.items():
        invalid = tmp_path / filename
        invalid.write_text(source, encoding="utf-8")
        rejected = run_scanner(tmp_path, scanner, invalid)
        assert rejected.returncode != 0, filename
        assert "forbidden Lean proof bypass" in rejected.stderr


def test_default_scan_ignores_local_backups(tmp_path: Path) -> None:
    scanner = prepare_scanner(tmp_path)

    library = tmp_path / "VerifiedAgenticWorkshop"
    playground = tmp_path / "playground"
    backup = playground / "backups" / "old-attempt"
    library.mkdir()
    backup.mkdir(parents=True)

    (library / "Checked.lean").write_text(
        "example : True := by trivial\n", encoding="utf-8"
    )
    (playground / "Committed.lean").write_text(
        "example : True := by trivial\n", encoding="utf-8"
    )
    (backup / "Current.lean").write_text(
        "example : True := by sorry\n", encoding="utf-8"
    )

    result = run_scanner(tmp_path, scanner)
    assert result.returncode == 0
