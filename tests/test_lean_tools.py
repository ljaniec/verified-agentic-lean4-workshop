from __future__ import annotations

from pathlib import Path

import pytest

from verified_agentic_workshop.tools import lean

_ALLOWED_PREFIXES = (
    "playground/",
    "VerifiedAgenticWorkshop/Scenarios/",
    "VerifiedAgenticWorkshop/Workshop/",
)


def test_listed_files_stay_inside_allowed_roots() -> None:
    result = lean.list_lean_files()
    assert result["status"] == "success"
    files = result["files"]
    assert files
    assert all(str(path).startswith(_ALLOWED_PREFIXES) for path in files)
    assert any(
        str(path).startswith("VerifiedAgenticWorkshop/Scenarios/") for path in files
    )


def test_path_traversal_is_rejected() -> None:
    result = lean.read_lean_file("../../etc/passwd.lean")
    assert result["status"] == "error"


def test_non_lean_file_is_rejected() -> None:
    result = lean.read_lean_file("playground/not-a-proof.txt")
    assert result["status"] == "error"


def _scan_source(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    filename: str,
    source: str,
) -> dict[str, object]:
    allowed = tmp_path / "playground"
    allowed.mkdir(exist_ok=True)
    target = allowed / filename
    target.write_text(source, encoding="utf-8")

    monkeypatch.setattr(lean, "_REPOSITORY_ROOT", tmp_path)
    monkeypatch.setattr(lean, "_ALLOWED_ROOTS", (allowed,))
    return lean.scan_lean_file(f"playground/{filename}")


def test_forbidden_construct_is_reported(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    result = _scan_source(
        tmp_path,
        monkeypatch,
        "Bad.lean",
        "example : True := (by sorry)\n",
    )
    assert result["status"] == "rejected"
    assert result["matches"] == [
        {"line": 1, "text": "example : True := (by sorry)"}
    ]


@pytest.mark.parametrize(
    "source",
    [
        "constant fabricated : False\n",
        "axiom fabricated : False\n",
        "example : False := Lean.sorryAx False true\n",
        "example : True := by native_decide\n",
    ],
)
def test_axiom_aliases_and_trust_bypasses_are_rejected(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch, source: str
) -> None:
    result = _scan_source(tmp_path, monkeypatch, "Bad.lean", source)
    assert result["status"] == "rejected"


def test_comments_and_strings_do_not_trigger_static_scan(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    result = _scan_source(
        tmp_path,
        monkeypatch,
        "Clean.lean",
        "-- Do not use `sorry` or `constant`.\n"
        "/- A block comment mentioning axiom and sorryAx. -/\n"
        '#eval "sorry is only a string"\n'
        "example : True := by trivial\n",
    )
    assert result == {
        "status": "success",
        "path": "playground/Clean.lean",
        "matches": [],
    }


def test_clean_file_passes_static_scan(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    result = _scan_source(
        tmp_path,
        monkeypatch,
        "Clean.lean",
        "example : True := by trivial\n",
    )
    assert result == {
        "status": "success",
        "path": "playground/Clean.lean",
        "matches": [],
    }
