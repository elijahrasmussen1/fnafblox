--!strict
-- Pure mapping from logical game state to visual presentation.
-- The renderer consumes these keys and resolves assets via VisualManifest.
local VisualResolver = {}
function VisualResolver.resolve(state)
    local view = {scene = "office", key = "idle", overlay = nil}
    if state.power <= 0 then
        view.key = "powerOut"
    elseif state.monitor then
        view.scene = "camera"
        view.key = state.camera or "1A"
        view.overlay = "static"
    elseif state.leftLight then
        view.key = "leftLight"
    elseif state.rightLight then
        view.key = "rightLight"
    end
    return view
end
return table.freeze(VisualResolver)
