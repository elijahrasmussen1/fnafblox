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
