# Milestone 01 — Project scaffold and title menu

## Structure

- `src/client/CameraLock.client.lua`: prevents character/camera movement.
- `src/client/Bootstrap.client.lua`: boots the 2D GUI and smoke-test controls.
- `src/client/AppController.lua`: top-level title/gameplay screen state.
- `src/client/MenuController.lua`: title screen, button input and placeholders.
- `src/client/VisualRenderer.lua`: image scene and overlay composition.
- `src/shared/MenuConfig.lua`: provisional menu configuration.
- `src/shared/VisualResolver.lua`: gameplay state -> scene key.
- `src/shared/VisualManifest.lua`: blank source-art mappings.
- `src/server/Bootstrap.server.lua`: experimental server-owned gameplay clock.

## Title menu contract

The title menu is the first visible screen. New Game transitions to the existing prototype gameplay GUI. Continue, Options, and Credits currently show explicit not-implemented messages instead of pretending to work. No original title assets, animations, static effects, save handling, or exact Clickteam menu transitions are implemented.

## Acceptance criteria to verify in Studio

1. The title menu appears on launch.
2. Character cannot walk, jump, or rotate; Roblox 3D camera remains fixed.
3. New Game hides the menu and exposes the gameplay smoke-test controls.
4. Continue/Options/Credits give accurate feedback.
5. No Luau runtime errors in Studio Output.

**Not yet Studio-tested.** Next work: identify the title-screen images and event sequences in `original/` and replace placeholders with a faithful image-driven menu.
