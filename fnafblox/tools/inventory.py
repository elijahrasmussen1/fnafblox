#!/usr/bin/env python3
"""Read-only deterministic inventory of original/ assets."""
from collections import Counter, defaultdict
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "original"
OUT = ROOT / "fnafblox" / "research" / "generated"

def main():
    if not SOURCE.is_dir():
        raise SystemExit(f"Missing original source: {SOURCE}")
    files = sorted(p for p in SOURCE.rglob("*") if p.is_file())
    groups = defaultdict(set)
    items = []
    for path in files:
        rel = path.relative_to(SOURCE).as_posix()
        ext = path.suffix.lower().lstrip(".")
        if ext in ("mp3", "ogg"):
            groups[path.stem].add(ext)
        items.append({"path": rel, "extension": ext, "bytes": path.stat().st_size})
    counts = dict(sorted(Counter(x["extension"] for x in items).items()))
    paired = sorted(k for k, v in groups.items() if {"mp3", "ogg"} <= v)
    unpaired = {k: sorted(v) for k, v in sorted(groups.items()) if len(v) == 1}
    report = {"file_count": len(items), "extension_counts": counts,
              "paired_audio_stems": paired, "unpaired_audio": unpaired, "files": items}
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / "inventory.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(f"Inventoried {len(items)} files; {len(paired)} audio pairs. Output: {OUT / 'inventory.json'}")

if __name__ == "__main__":
    main()
