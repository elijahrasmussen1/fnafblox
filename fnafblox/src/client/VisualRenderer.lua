--!strict
-- Frame/image driven presentation; placeholders remain blank until source art is mapped.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local shared = ReplicatedStorage:WaitForChild("Fnafblox")
local manifest = require(shared:WaitForChild("VisualManifest"))
local resolver = require(shared:WaitForChild("VisualResolver"))
local Renderer = {}
function Renderer.create(parent)
    local canvas = Instance.new("Frame")
    canvas.Name = "VisualCanvas"
    canvas.Size = UDim2.fromScale(1, 1)
    canvas.BackgroundColor3 = Color3.fromRGB(7, 7, 10)
    canvas.BorderSizePixel = 0
    canvas.ZIndex = 0
    canvas.Parent = parent
    local image = Instance.new("ImageLabel")
    image.Name = "SceneImage"
    image.Size = UDim2.fromScale(1, 1)
    image.BackgroundTransparency = 1
    image.ScaleType = Enum.ScaleType.Fit
    image.ZIndex = 1
    image.Parent = canvas
    local overlay = Instance.new("ImageLabel")
    overlay.Name = "OverlayImage"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundTransparency = 1
    overlay.ScaleType = Enum.ScaleType.Stretch
    overlay.ZIndex = 2
    overlay.Parent = canvas
    local self = {}
    function self.render(state)
        local view = resolver.resolve(state)
        local scene = manifest[view.scene]
        image.Image = (scene and scene[view.key]) or ""
        overlay.Image = view.overlay and (manifest.overlays[view.overlay] or "") or ""
        canvas:SetAttribute("Scene", view.scene)
        canvas:SetAttribute("FrameKey", view.key)
    end
    function self.destroy()
        canvas:Destroy()
    end
    return self
end
return table.freeze(Renderer)
