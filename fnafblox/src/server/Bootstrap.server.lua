--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local config = require(ReplicatedStorage:WaitForChild("Fnafblox"):WaitForChild("GameConfig"))
local remotes = Instance.new("Folder")
remotes.Name = "FnafbloxRemotes"
remotes.Parent = ReplicatedStorage
local command = Instance.new("RemoteEvent")
command.Name = "Command"
command.Parent = remotes
local snapshot = Instance.new("RemoteEvent")
snapshot.Name = "Snapshot"
snapshot.Parent = remotes
local states = {}
local controls = {"monitor", "leftDoor", "rightDoor", "leftLight", "rightLight"}
Players.PlayerAdded:Connect(function(player)
    local state = {elapsed = 0, power = config.START_POWER, finished = false, result = ""}
    for _, key in ipairs(controls) do state[key] = false end
    states[player] = state
    task.defer(function()
        if states[player] then snapshot:FireClient(player, table.clone(state)) end
    end)
end)
Players.PlayerRemoving:Connect(function(player) states[player] = nil end)
command.OnServerEvent:Connect(function(player, key, value)
    local state = states[player]
    if not state or state.finished or state.power <= 0 then return end
    if type(key) ~= "string" or type(value) ~= "boolean" or not table.find(controls, key) then return end
    state[key] = value
    snapshot:FireClient(player, table.clone(state))
end)
task.spawn(function()
    while true do
        local dt = math.min(task.wait(0.2), 1)
        for player, state in pairs(states) do
            if state.finished then continue end
            state.elapsed += dt
            local count = 0
            for _, key in ipairs(controls) do
                if state[key] then count += 1 end
            end
            state.power = math.max(0, state.power - dt * (config.BASE_DRAIN + config.DEVICE_DRAIN * count))
            if state.power <= 0 then
                state.finished = true
                state.result = "POWER OUT"
                for _, key in ipairs(controls) do state[key] = false end
            elseif state.elapsed >= config.NIGHT_SECONDS then
                state.finished = true
                state.result = "6 AM"
            end
            if player.Parent then snapshot:FireClient(player, table.clone(state)) end
        end
    end
end
