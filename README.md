# fnafblox — Clickteam-to-Roblox research monorepo

This repository separates an **unaltered snapshot of the imported HTML5 game** from a new **Roblox/Luau reconstruction workspace**.

## Layout

- `original/` — byte-identical Git objects from the imported FNAF1 HTML5 tree (HTML, Clickteam runtime, binary data, media). **Do not edit.**
- `fnafblox/` — Roblox implementation and research tooling; no playable port yet.

## First extraction pass

```sh
python3 fnafblox/tools/inventory.py
python3 fnafblox/tools/probe_clickteam.py
```

Outputs are written under `fnafblox/research/generated/` (ignored by Git). The first tool inventories media and groups paired sound encodings. The second safely probes Clickteam binary headers and attempts zlib decompression with bounded output. **It does not claim to decode game events.**

See `fnafblox/research/STATUS.md` for verified findings, unknowns, and next steps.

## Origin and rights

Original imported source: https://github.com/sussygamedeveloper/FNAF1 . The Clickteam runtime has its own restrictive copyright notice; game assets may be subject to third-party rights. Keeping the original here is for comparison, not a grant of redistribution rights.
