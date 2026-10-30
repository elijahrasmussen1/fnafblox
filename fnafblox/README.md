# Roblox Studio workspace

The first **Luau smoke-test prototype** is now committed. It includes a server-authoritative timer, power simulation, and five UI toggles (monitor, two doors, two lights).

**Not yet implemented:** original artwork, camera images, animatronic AI, jumpscares, sound, save data, or exact original gameplay values. The timing and drain values are placeholders.

## Open when you're back at your computer

1. Install the Rojo CLI and Studio plugin: https://rojo.space/
2. Clone this repository and open a terminal in `fnafblox/`.
3. Run `rojo serve default.project.json`.
4. In Roblox Studio, open a blank place and connect the Rojo plugin.
5. Press Play. Verify the clock and power tick down and all five toggles respond.

The original HTML5 tree is untouched under `../original/`. Binary extraction tools are under `tools/`; generated reports are ignored by Git.

## Research status

- The `.cc1` archive is confirmed ZIP with `Application.ccj` inside.
- The ZIP extractor is committed; full internal event/object parsing is not yet complete.
- The prototype is **not Studio-tested** yet; do not interpret a successful commit as a successful playtest.
