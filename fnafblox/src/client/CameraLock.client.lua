--!strict
-- Roblox 3D camera is a fixed host for our 2D presentation.
-- No character controls, camera tracking, zoom, or mouse-lock look.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local player = Players.LocalPlayer
local CAMERA_BIND = "FnafbloxFixedCamera"
local BLOCK_ACTION = "FnafbloxBlockMovement"
local BLOCK_KEYS = {
    Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
    Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right,
    Enum.KeyCode.Space, Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift,
    Enum.KeyCode.ButtonA, Enum.KeyCode.Thumbstick1,
}
local function lockCharacter(character: Model)
    local humanoid = character:WaitForChild("Humanoid") :: Humanoid
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.JumpHeight = 0
    humanoid.AutoRotate = false
    local root = character:WaitForChild("HumanoidRootPart") :: BasePart
    root.Anchored = true
end
local function fixedCamera()
    local camera = workspace.CurrentCamera
    if not camera then return end
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = CFrame.new(0, 30, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    camera.Focus = camera.CFrame * CFrame.new(0, 0, -10)
    camera.FieldOfView = 70
end
ContextActionService:BindActionAtPriority(
    BLOCK_ACTION,
    function() return Enum.ContextActionResult.Sink end,
    false,
    Enum.ContextActionPriority.High.Value + 100,
    table.unpack(BLOCK_KEYS)
)
player.CharacterAdded:Connect(lockCharacter)
if player.Character then task.spawn(lockCharacter, player.Character) end
RunService:BindToRenderStep(CAMERA_BIND, Enum.RenderPriority.Camera.Value + 1, fixedCamera)
fixedCamera()
