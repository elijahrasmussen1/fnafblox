# Image-driven reconstruction architecture

FNAF1's rendered scenes should be modeled as **visual states**, not 3D NPC motion.

1. **Logical state**: camera location, AI positions, lights, doors, power, time, and event triggers.
2. **Visual resolver**: deterministic state -> scene/frame key.
3. **Manifest**: scene/frame key -> approved Roblox asset ID(s).
4. **Renderer**: ImageLabels for base scene, overlays, and frame sequences.

## Why separate these?

A room change changes a logical position; the camera image changes only when the visual resolver chooses a different frame. Animation sequences are ordered frame keys with durations, not Roblox character animation tracks. Static, flashes, and jumpscares are layered image sequences. Original art and timings must be mapped from the Clickteam application, rather than guessed.

## Current limits

The manifest has blank IDs because the original numeric PNG files have not been visually identified or uploaded to Roblox. The resolver handles only basic office/monitor/power states and is **not an exact port** of original event rules. Camera images, movement-specific variants, door positions, and frame timing remain to be extracted.

Next: generate PNG contact sheets, correlate source images to frame/object references, and implement a timed sprite-sequence player with test fixtures.

## Fixed Roblox camera / image panning

- `src/client/CameraLock.client.lua` makes the Roblox camera `Scriptable`, reasserts its fixed transform each render frame, anchors the player's root, disables humanoid movement/jump, and sinks common movement inputs. This is a prototype lock, not a server-enforced anti-cheat system.
- `src/client/VisualRenderer.lua` clips the office scene to the GUI canvas and pans a 1.25x-wide office image based on mouse/touch horizontal position. Camera-monitor scenes remain fixed within the canvas.
- The 1.25 ratio comes from a provisional 1600-wide office versus a 1280-wide viewport; it must be confirmed against mapped original assets. Images are not yet uploaded, so panning is not visually testable yet.
- No 3D camera motion should be used to simulate looking around the office.
