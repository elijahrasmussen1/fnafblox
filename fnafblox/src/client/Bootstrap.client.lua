--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remotes = ReplicatedStorage:WaitForChild("FnafbloxRemotes")
local command = remotes:WaitForChild("Command")
local snapshot = remotes:WaitForChild("Snapshot")
local gui = Instance.new("ScreenGui")
gui.Name = "FnafbloxPrototype"
gui.ResetOnSpawn = false
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
local renderer = require(script.Parent:WaitForChild("VisualRenderer"))
local root = Instance.new("Frame")
root.Size = UDim2.fromScale(1, 1)
root.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
root.Parent = gui
local visuals = renderer.create(root)
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Parent = root
local function makeLabel(value)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.85, 0, 0, 40)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Code
    label.TextScaled = true
    label.Text = value
    label.Parent = root
    return label
end
makeLabel("FNAFBLOX | STUDIO SMOKE TEST")
local status = makeLabel("Connecting...")
local controls = {
    {"Monitor", "monitor"}, {"Left Door", "leftDoor"},
    {"Right Door", "rightDoor"}, {"Left Light", "leftLight"},
    {"Right Light", "rightLight"},
}
local state = {}
local buttons = {}
for _, control in ipairs(controls) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 42)
    button.BackgroundColor3 = Color3.fromRGB(37, 37, 48)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Font = Enum.Font.Code
    button.Parent = root
    buttons[control[2]] = {button = button, name = control[1]}
    button.Activated:Connect(function()
        command:FireServer(control[2], not state[control[2]])
    end)
end
snapshot.OnClientEvent:Connect(function(data)
    if type(data) ~= "table" then return end
    state = data
    visuals.render(data)
    local hour = math.min(6, math.floor((data.elapsed or 0) / 60))
    local timeText = hour == 0 and "12 AM" or tostring(hour) .. " AM"
    status.Text = string.format("%s | Power %.1f%% | %s", timeText, data.power or 0, data.finished and data.result or "RUNNING")
    for key, item in pairs(buttons) do
        item.button.Text = item.name .. ": " .. (data[key] and "ON" or "OFF")
    end
end)
