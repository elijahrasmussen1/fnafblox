--!strict
-- Frame/image driven presentation; placeholders remain blank until source art is mapped.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
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
    canvas.ClipsDescendants = true
    canvas.ZIndex = 0
    canvas.Parent = parent
    local image = Instance.new("ImageLabel")
    image.Name = "SceneImage"
    image.Size = UDim2.fromScale(1, 1)
    image.BackgroundTransparency = 1
    image.ScaleType = Enum.ScaleType.Stretch
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
    local officeView = true
    local pan = 0.5
    local targetPan = 0.5
    local touchPan = nil
    local touchConnection = UserInputService.TouchMoved:Connect(function(input)
        local left = canvas.AbsolutePosition.X
        local width = canvas.AbsoluteSize.X
        if width > 0 then touchPan = math.clamp((input.Position.X - left) / width, 0, 1) end
    end)
    local touchEndConnection = UserInputService.TouchEnded:Connect(function()
        touchPan = nil
    end)
    local renderConnection = RunService.RenderStepped:Connect(function(dt)
        if officeView then
            local width = canvas.AbsoluteSize.X
            if width > 0 then
                local mouseX = UserInputService:GetMouseLocation().X
                targetPan = touchPan or math.clamp((mouseX - canvas.AbsolutePosition.X) / width, 0, 1)
            end
            pan += (targetPan - pan) * (1 - math.exp(-dt * 7))
            -- 1600-wide office viewed through a 1280-wide canvas (1.25x).
            image.Size = UDim2.fromScale(1.25, 1)
            image.Position = UDim2.fromScale(-0.25 * pan, 0)
        else
            image.Size = UDim2.fromScale(1, 1)
            image.Position = UDim2.fromScale(0, 0)
        end
    end)
    function self.render(state)
        local view = resolver.resolve(state)
        officeView = view.scene == "office"
        local scene = manifest[view.scene]
        image.Image = (scene and scene[view.key]) or ""
        overlay.Image = view.overlay and (manifest.overlays[view.overlay] or "") or ""
        canvas:SetAttribute("Scene", view.scene)
        canvas:SetAttribute("FrameKey", view.key)
    end
    function self.destroy()
        renderConnection:Disconnect()
        touchConnection:Disconnect()
        touchEndConnection:Disconnect()
        canvas:Destroy()
    end
    return self
end
return table.freeze(Renderer)
