#!/usr/bin/env python3
"""Extract the Clickteam application from the original ZIP container and inspect it.

Requires only Python 3 stdlib. Does not execute untrusted game code.
"""
from pathlib import Path
from collections import Counter
import hashlib
import json
import re
import struct
import zipfile

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "original/resources/FNAF1HTML5.cc1"
OUTPUT = ROOT / "fnafblox/research/generated"
MAX_SIZE = 32 * 1024 * 1024

def ascii_strings(data, min_len=4):
    matches = []
    for m in re.finditer(rb"[\x20-\x7e]{4,}", data):
        value = m.group().decode("ascii")
        if len(value) >= min_len:
            matches.append({"offset": m.start(), "text": value[:200]})
    return matches

def utf16_strings(data, min_len=4):
    matches = []
    for m in re.finditer(rb"(?:[\x20-\x7e]\x00){4,}", data):
        value = m.group().decode("utf-16le")
        if len(value) >= min_len:
            matches.append({"offset": m.start(), "text": value[:200]})
    return matches

def main():
    if not SOURCE.exists():
        raise SystemExit("Missing original/resources/FNAF1HTML5.cc1")
    OUTPUT.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(SOURCE) as archive:
        info = archive.infolist()
        if len(info) != 1 or info[0].filename != "Application.ccj":
            raise SystemExit("Unexpected archive contents; refusing to extract")
        member = info[0]
        if member.file_size > MAX_SIZE:
            raise SystemExit("Application exceeds extraction safety limit")
        with archive.open(member) as stream:
            data = stream.read(MAX_SIZE + 1)
        if len(data) != member.file_size:
            raise SystemExit("Unexpected decompressed size")
    (OUTPUT / "Application.ccj").write_bytes(data)
    strings = ascii_strings(data)
    wide = utf16_strings(data)
    report = {
        "container": SOURCE.relative_to(ROOT).as_posix(),
        "archive_type": "ZIP",
        "member": "Application.ccj",
        "compression_method": member.compress_type,
        "compressed_bytes": member.compress_size,
        "uncompressed_bytes": len(data),
        "sha256": hashlib.sha256(data).hexdigest(),
        "first_64_bytes_hex": data[:64].hex(),
        "ascii_strings": strings,
        "utf16le_strings": wide,
        "note": "Strings are forensic leads, not decoded Clickteam events or frame definitions.",
    }
    (OUTPUT / "application_inspection.json").write_text(
        json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print("Extracted Application.ccj:", len(data), "bytes")
    print("ASCII strings:", len(strings), "UTF-16LE strings:", len(wide))
    print("Output:", OUTPUT)

if __name__ == "__main__":
    main()
