# fnafblox — Roblox Studio project

## Milestone 01: structure and menu (in progress)

The app now **boots into a native Roblox GUI title menu**. Selecting **New Game** hides the menu and reveals the existing experimental gameplay controls. **Continue**, **Options**, and **Credits** currently show placeholder messages. This is not yet a visual recreation of the original title screen.

The 3D character and camera are locked by `CameraLock.client.lua`. Office movement is intended to be rendered by panning GUI images, not moving Roblox's camera.

### Code layout

- `src/client/Bootstrap.client.lua` — UI startup and prototype controls
- `src/client/AppController.lua` — menu/gameplay screen transitions
- `src/client/MenuController.lua` — title menu and input
- `src/client/CameraLock.client.lua` — fixed Roblox camera and character
- `src/client/VisualRenderer.lua` — image-based scene canvas
- `src/shared/MenuConfig.lua` — provisional menu configuration
- `src/shared/VisualManifest.lua` and `VisualResolver.lua` — scene state and image mappings
- `src/server/Bootstrap.server.lua` — prototype server state

See `research/MILESTONE_01.md` for acceptance criteria and limitations.

### Open in Studio later

1. Install Rojo CLI and Studio plugin: https://rojo.space/
2. Clone the repository and run `rojo serve default.project.json` inside `fnafblox/`.
3. Open a blank place in Roblox Studio, connect the Rojo plugin, and Play.

**Not yet Studio-tested.** Original title artwork, sprite animation, static effects, sound, and save logic have not been mapped. All gameplay timing values remain provisional. Original source is preserved in `../original/`.
