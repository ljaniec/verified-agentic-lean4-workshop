"""Safe-by-default wrappers around the local Lean project.

The agent never receives a general shell tool. It can only inspect or compile
Lean files under the workshop's explicitly allowed directories.
"""

from __future__ import annotations

import os
import re
import subprocess
from pathlib import Path
from typing import Final

_REPOSITORY_ROOT: Final[Path] = Path(__file__).resolve().parents[3]
_ALLOWED_ROOTS: Final[tuple[Path, ...]] = (
    _REPOSITORY_ROOT / "playground",
    _REPOSITORY_ROOT / "VerifiedAgenticWorkshop" / "Scenarios",
    _REPOSITORY_ROOT / "VerifiedAgenticWorkshop" / "Workshop",
)
_FORBIDDEN_PATTERN: Final[re.Pattern[str]] = re.compile(
    r"(?<![A-Za-z0-9_])"
    r"(sorry|admit|axiom|constant|sorryAx|native_decide|implemented_by)"
    r"(?![A-Za-z0-9_])"
)


def _output_limit() -> int:
    return int(os.getenv("LEAN_CHECK_OUTPUT_LIMIT", "12000"))


def _timeout_seconds() -> int:
    return int(os.getenv("LEAN_CHECK_TIMEOUT_SECONDS", "60"))


def _truncate(text: str) -> str:
    limit = _output_limit()
    if len(text) <= limit:
        return text
    return text[:limit] + f"\n... output truncated after {limit} characters"


def _decode_timeout_output(value: str | bytes | None) -> str:
    if value is None:
        return ""
    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")
    return value


def _resolve_lean_file(relative_path: str) -> Path:
    candidate = (_REPOSITORY_ROOT / relative_path).resolve()
    if candidate.suffix != ".lean":
        raise ValueError("Only .lean files are accepted.")
    if not any(candidate.is_relative_to(root.resolve()) for root in _ALLOWED_ROOTS):
        raise ValueError(
            "The file must be inside playground/, "
            "VerifiedAgenticWorkshop/Scenarios/, or "
            "VerifiedAgenticWorkshop/Workshop/."
        )
    if not candidate.is_file():
        raise FileNotFoundError(f"Lean file does not exist: {relative_path}")
    return candidate


def _code_lines(source: str) -> list[str]:
    """Remove Lean comments and string contents while preserving line numbers."""

    code_lines: list[str] = []
    block_depth = 0

    for line in source.splitlines():
        code: list[str] = []
        in_string = False
        escaped = False
        index = 0

        while index < len(line):
            char = line[index]
            next_char = line[index + 1] if index + 1 < len(line) else ""

            if block_depth > 0:
                if char == "/" and next_char == "-":
                    block_depth += 1
                    index += 2
                    continue
                if char == "-" and next_char == "/":
                    block_depth -= 1
                    index += 2
                    continue
                index += 1
                continue

            if in_string:
                if escaped:
                    escaped = False
                elif char == "\\":
                    escaped = True
                elif char == '"':
                    in_string = False
                index += 1
                continue

            if char == "-" and next_char == "-":
                break
            if char == "/" and next_char == "-":
                block_depth += 1
                index += 2
                continue
            if char == '"':
                in_string = True
                index += 1
                continue

            code.append(char)
            index += 1

        code_lines.append("".join(code))

    return code_lines


def list_lean_files() -> dict[str, object]:
    """List Lean files that the workshop agent is allowed to inspect."""

    files: list[str] = []
    for root in _ALLOWED_ROOTS:
        if root.is_dir():
            files.extend(
                str(path.relative_to(_REPOSITORY_ROOT))
                for path in sorted(root.rglob("*.lean"))
            )
    return {"status": "success", "files": files}


def read_lean_file(relative_path: str) -> dict[str, object]:
    """Read one allowed Lean file without executing it."""

    try:
        path = _resolve_lean_file(relative_path)
        return {
            "status": "success",
            "path": str(path.relative_to(_REPOSITORY_ROOT)),
            "content": _truncate(path.read_text(encoding="utf-8")),
        }
    except (FileNotFoundError, ValueError) as error:
        return {"status": "error", "error": str(error)}


def scan_lean_file(relative_path: str) -> dict[str, object]:
    """Scan one allowed Lean file for proof-bypassing constructs."""

    try:
        path = _resolve_lean_file(relative_path)
        source = path.read_text(encoding="utf-8")
        original_lines = source.splitlines()
        matches: list[dict[str, object]] = []

        for line_number, code in enumerate(_code_lines(source), start=1):
            if _FORBIDDEN_PATTERN.search(code):
                matches.append(
                    {
                        "line": line_number,
                        "text": original_lines[line_number - 1].strip(),
                    }
                )

        return {
            "status": "success" if not matches else "rejected",
            "path": str(path.relative_to(_REPOSITORY_ROOT)),
            "matches": matches,
        }
    except (FileNotFoundError, ValueError) as error:
        return {"status": "error", "error": str(error)}


def check_lean_file(relative_path: str) -> dict[str, object]:
    """Compile one allowed Lean file with the repository's pinned toolchain."""

    scan = scan_lean_file(relative_path)
    if scan.get("status") != "success":
        return {
            "status": "rejected",
            "reason": "The source contains a forbidden construct or is inaccessible.",
            "scan": scan,
        }

    try:
        path = _resolve_lean_file(relative_path)
        completed = subprocess.run(
            [
                "lake",
                "env",
                "lean",
                "-DwarningAsError=true",
                str(path.relative_to(_REPOSITORY_ROOT)),
            ],
            cwd=_REPOSITORY_ROOT,
            check=False,
            capture_output=True,
            text=True,
            timeout=_timeout_seconds(),
            env={**os.environ, "NO_COLOR": "1"},
        )
    except FileNotFoundError:
        return {
            "status": "error",
            "error": "The `lake` executable is unavailable. Run scripts/setup.sh.",
        }
    except subprocess.TimeoutExpired as error:
        return {
            "status": "timeout",
            "error": f"Lean exceeded the {_timeout_seconds()} second limit.",
            "stdout": _truncate(_decode_timeout_output(error.stdout)),
            "stderr": _truncate(_decode_timeout_output(error.stderr)),
        }

    output = _truncate(completed.stdout + completed.stderr)
    return {
        "status": "verified" if completed.returncode == 0 else "failed",
        "returncode": completed.returncode,
        "path": str(path.relative_to(_REPOSITORY_ROOT)),
        "output": output,
    }
