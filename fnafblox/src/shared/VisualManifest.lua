--!strict
-- Image IDs are intentionally unassigned until the numbered source PNGs are mapped
-- and imported into Roblox with appropriate permissions.
-- Each visual is a logical state, not a physical 3D scene.
return table.freeze({
    office = {idle = "", leftLight = "", rightLight = "", powerOut = ""},
    camera = {["1A"] = "", ["1B"] = "", ["1C"] = "", ["2A"] = "", ["2B"] = "", ["3"] = "", ["4A"] = "", ["4B"] = "", ["5"] = "", ["6"] = "", ["7"] = ""},
    overlays = {static = "", blackout = ""},
    sequences = {monitorOpen = {}, monitorClose = {}, jumpscare = {}},
})
