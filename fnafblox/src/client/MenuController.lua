--!strict
-- 2D title screen and local menu state; gameplay is not started by this module.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local config = require(ReplicatedStorage:WaitForChild("Fnafblox"):WaitForChild("MenuConfig"))
local MenuController = {}
function MenuController.create(parent: Instance, onStart: (number) -> ())
    local root = Instance.new("Frame")
    root.Name = "TitleMenu"
    root.Size = UDim2.fromScale(1, 1)
    root.BackgroundColor3 = Color3.fromRGB(8, 8, 9)
    root.BorderSizePixel = 0
    root.ZIndex = 10
    root.Parent = parent
    local scanlines = Instance.new("Frame")
    scanlines.Name = "MenuArtPlaceholder"
    scanlines.Size = UDim2.fromScale(0.55, 1)
    scanlines.Position = UDim2.fromScale(0.45, 0)
    scanlines.BackgroundColor3 = Color3.fromRGB(16, 16, 19)
    scanlines.BorderSizePixel = 0
    scanlines.ZIndex = 10
    scanlines.Parent = root
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Position = UDim2.fromScale(0.06, 0.12)
    title.Size = UDim2.fromScale(0.45, 0.22)
    title.BackgroundTransparency = 1
    title.Text = config.title
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Top
    title.Font = Enum.Font.Code
    title.TextSize = 34
    title.TextColor3 = Color3.new(1, 1, 1)
    title.ZIndex = 11
    title.Parent = root
    local status = Instance.new("TextLabel")
    status.Name = "MenuStatus"
    status.Position = UDim2.fromScale(0.06, 0.79)
    status.Size = UDim2.fromScale(0.4, 0.12)
    status.BackgroundTransparency = 1
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.TextWrapped = true
    status.Font = Enum.Font.Code
    status.TextSize = 15
    status.TextColor3 = Color3.fromRGB(170, 170, 170)
    status.ZIndex = 11
    status.Parent = root
    local function setStatus(message: string)
        status.Text = message
    end
    local buttons = {}
    local function addButton(label: string, index: number)
        local button = Instance.new("TextButton")
        button.Name = label:gsub("%s+", "") .. "Button"
        button.Position = UDim2.fromScale(0.06, 0.39 + (index - 1) * 0.09)
        button.Size = UDim2.fromScale(0.32, 0.075)
        button.BackgroundTransparency = 1
        button.Text = label
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.TextColor3 = Color3.fromRGB(235, 235, 235)
        button.TextSize = 24
        button.Font = Enum.Font.Code
        button.ZIndex = 11
        button.Parent = root
        button.MouseEnter:Connect(function()
            button.Text = "> " .. label
        end)
        button.MouseLeave:Connect(function()
            button.Text = label
        end)
        button.Activated:Connect(function()
            if label == "New Game" then
                onStart(config.initialNight)
            elseif label == "Continue" then
                setStatus("Continue is unavailable until save data is implemented.")
            elseif label == "Options" then
                setStatus("Options screen is not implemented yet.")
            elseif label == "Credits" then
                setStatus("Original game assets and mechanics are being researched.")
            end
        end)
        buttons[label] = button
    end
    for index, label in ipairs(config.buttons) do
        addButton(label, index)
    end
    setStatus("2D menu prototype | source artwork pending")
    local controller = {}
    function controller.show()
        root.Visible = true
    end
    function controller.hide()
        root.Visible = false
    end
    function controller.destroy()
        root:Destroy()
    end
    return controller
end
return table.freeze(MenuController)
