from __future__ import annotations

from pathlib import Path

import pytest

from verified_agentic_workshop.tools import lean


def test_listed_files_stay_inside_allowed_roots() -> None:
    result = lean.list_lean_files()
    assert result["status"] == "success"
    files = result["files"]
    assert files
    assert all(
        str(path).startswith(("playground/", "VerifiedAgenticWorkshop/Workshop/"))
        for path in files
    )


def test_path_traversal_is_rejected() -> None:
    result = lean.read_lean_file("../../etc/passwd.lean")
    assert result["status"] == "error"


def test_non_lean_file_is_rejected() -> None:
    result = lean.read_lean_file("playground/not-a-proof.txt")
    assert result["status"] == "error"


def test_forbidden_construct_is_reported(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    allowed = tmp_path / "playground"
    allowed.mkdir()
    bad = allowed / "Bad.lean"
    bad.write_text("example : True := by sorry\n", encoding="utf-8")

    monkeypatch.setattr(lean, "_REPOSITORY_ROOT", tmp_path)
    monkeypatch.setattr(lean, "_ALLOWED_ROOTS", (allowed,))

    result = lean.scan_lean_file("playground/Bad.lean")
    assert result["status"] == "rejected"
    assert result["matches"] == [{"line": 1, "text": "example : True := by sorry"}]


def test_clean_file_passes_static_scan(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    allowed = tmp_path / "playground"
    allowed.mkdir()
    clean = allowed / "Clean.lean"
    clean.write_text("example : True := by trivial\n", encoding="utf-8")

    monkeypatch.setattr(lean, "_REPOSITORY_ROOT", tmp_path)
    monkeypatch.setattr(lean, "_ALLOWED_ROOTS", (allowed,))

    result = lean.scan_lean_file("playground/Clean.lean")
    assert result == {
        "status": "success",
        "path": "playground/Clean.lean",
        "matches": [],
    }
