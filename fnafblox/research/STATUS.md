# Extraction status — phase 1

## Verified from GitHub tree and source inspection

- 368 original files: 258 PNG, 53 MP3, 52 OGG, one HTML, one JS, two Clickteam data files, one README.
- `original/index.html` loads `original/src/Runtime.js` and initializes `resources/FNAF1HTML5.cch` in a 1280×720 canvas.
- `original/src/Runtime.js` is Clickteam HTML5 runtime code (~1.19 MB), not isolated gameplay source.
- `original/resources/FNAF1HTML5.cch` is 6 bytes; `.cc1` is 31,688 bytes.
- 52 MP3/OGG basename pairs and an additional `9999.mp3`.
- The original tree is preserved as one nested Git tree, not copied or regenerated.

## Not yet verified / not extracted

- Frame list, object tables, event conditions/actions, AI thresholds, asset-to-object relationships, and compressed container structure.
- Actual visual contents of each numbered PNG.
- Exact gameplay behavior and completeness of demo vs retail content.

## Next investigation

1. Run the probes locally and retain raw output as evidence.
2. Identify `.cch` / `.cc1` file format, offsets, compression and any referenced companion data.
3. Parse frame/event/object tables **only after** confirming binary structure, with fixtures and tests.
4. Produce an image contact sheet and human-reviewed asset map.
5. Implement native Luau modules from recovered behavior, recording source evidence vs approximations.

No gameplay scripts or Roblox place files have been created in this phase.
