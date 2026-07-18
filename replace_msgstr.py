#!/usr/bin/env python3

from __future__ import annotations

import argparse
import ast
import re
import sys
from pathlib import Path


TOKEN_RE = re.compile(r"^(msgctxt|msgid_plural|msgid|msgstr(?:\[\d+\])?)\s*(.*)$")


def decode_po_fragment(fragment: str) -> str:
    fragment = fragment.strip()
    if not fragment:
        return ""
    return ast.literal_eval(fragment)


def encode_po_string(value: str) -> str:
    return '"' + (
        value.replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("\t", "\\t")
        .replace("\r", "\\r")
        .replace("\n", "\\n")
    ) + '"'


def parse_segments(lines: list[str]) -> list[dict[str, object]]:
    segments: list[dict[str, object]] = []
    current: dict[str, object] | None = None

    for idx, line in enumerate(lines):
        if line.startswith("#~"):
            return []

        match = TOKEN_RE.match(line)
        if match:
            if current is not None:
                segments.append(current)
            current = {
                "kind": match.group(1),
                "start": idx,
                "end": idx,
                "fragments": [match.group(2)],
            }
            continue

        if line.startswith('"') and current is not None:
            current["fragments"].append(line)
            current["end"] = idx
            continue

        if current is not None:
            segments.append(current)
            current = None

    if current is not None:
        segments.append(current)

    return segments


def entry_msgid(segments: list[dict[str, object]]) -> str | None:
    for segment in segments:
        if segment["kind"] == "msgid":
            fragments = segment["fragments"]
            return "".join(decode_po_fragment(fragment) for fragment in fragments)
    return None


def replace_entry(lines: list[str], target_msgid: str, new_value: str) -> tuple[list[str], bool]:
    segments = parse_segments(lines)
    if not segments:
        return lines, False

    msgid = entry_msgid(segments)
    if msgid != target_msgid:
        return lines, False

    segment_by_start = {
        segment["start"]: segment
        for segment in segments
        if str(segment["kind"]).startswith("msgstr")
    }

    output: list[str] = []
    changed = False
    idx = 0

    while idx < len(lines):
        segment = segment_by_start.get(idx)
        if segment is not None:
            kind = str(segment["kind"])
            output.append(f"{kind} {encode_po_string(new_value)}")
            changed = True
            idx = int(segment["end"]) + 1
            continue

        output.append(lines[idx])
        idx += 1

    return output, changed


def iter_po_files(domain: str) -> list[Path]:
    return sorted(Path(".").glob(f"*/LC_MESSAGES/{domain}.po"))


def main() -> int:
    parser = argparse.ArgumentParser(
        description=(
            "Replace a msgstr for one msgid across every locale file that uses a given textdomain."
        )
    )
    parser.add_argument("textdomain", help="The gettext textdomain, without the .po suffix")
    parser.add_argument("msgid", help="The exact msgid to replace")
    parser.add_argument("new_string", help="The new msgstr to write into every matching file")
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would change without writing files",
    )
    args = parser.parse_args()

    po_files = iter_po_files(args.textdomain)
    if not po_files:
        print(f"No .po files found for textdomain: {args.textdomain}", file=sys.stderr)
        return 1

    updated_files: list[Path] = []

    for po_file in po_files:
        original = po_file.read_text(encoding="utf-8")
        had_trailing_newline = original.endswith("\n")
        lines = original.splitlines()

        rebuilt: list[str] = []
        changed = False
        idx = 0

        while idx < len(lines):
            if lines[idx] == "":
                rebuilt.append("")
                idx += 1
                continue

            entry_start = idx
            while idx < len(lines) and lines[idx] != "":
                idx += 1

            entry_lines = lines[entry_start:idx]
            rewritten, entry_changed = replace_entry(entry_lines, args.msgid, args.new_string)
            rebuilt.extend(rewritten)
            changed = changed or entry_changed

        if changed:
            new_text = "\n".join(rebuilt) + ("\n" if had_trailing_newline else "")
            if not args.dry_run:
                po_file.write_text(new_text, encoding="utf-8")
            updated_files.append(po_file)

    if updated_files:
        action = "Would update" if args.dry_run else "Updated"
        print(f"{action} {len(updated_files)} file(s) for {args.textdomain}:")
        for po_file in updated_files:
            print(f"- {po_file}")
    else:
        print(f"No matching msgid found for {args.textdomain}.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
