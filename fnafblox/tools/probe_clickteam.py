#!/usr/bin/env python3
"""Conservative binary reconnaissance; never executes or modifies source files."""
from pathlib import Path
import hashlib
import json
import zlib

ROOT = Path(__file__).resolve().parents[2]
DATA = ROOT / "original" / "resources"
OUT = ROOT / "fnafblox" / "research" / "generated"
MAX_DECOMPRESSED = 16 * 1024 * 1024

def try_zlib(data, offset):
    obj = zlib.decompressobj()
    try:
        part = obj.decompress(data[offset:], MAX_DECOMPRESSED + 1)
        if len(part) > MAX_DECOMPRESSED:
            return None
        tail = obj.flush(MAX_DECOMPRESSED + 1 - len(part))
        output = part + tail
        if not obj.eof or len(output) > MAX_DECOMPRESSED:
            return None
        return {"offset": offset, "bytes": len(output), "sha256": hashlib.sha256(output).hexdigest(),
                "preview_hex": output[:32].hex()}
    except (zlib.error, ValueError):
        return None

def main():
    report = {}
    for filename in ("FNAF1HTML5.cch", "FNAF1HTML5.cc1"):
        path = DATA / filename
        data = path.read_bytes()
        matches = [r for off in range(min(len(data), 256)) if (r := try_zlib(data, off))]
        report[filename] = {"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest(),
                            "header_hex": data[:64].hex(), "zlib_candidates": matches}
    OUT.mkdir(parents=True, exist_ok=True)
    destination = OUT / "binary_probe.json"
    destination.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))
    print(f"Saved {destination}")

if __name__ == "__main__":
    main()
