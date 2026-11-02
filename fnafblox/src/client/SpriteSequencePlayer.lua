--!strict
-- Plays timed 2D sprite sequences using ImageLabels; no 3D camera or character motion.
-- Frames: {image = "rbxassetid://...", duration = 0.08}, with optional transparency.
local RunService = game:GetService("RunService")
local SpriteSequencePlayer = {}
function SpriteSequencePlayer.create(imageLabel: ImageLabel)
    local connection: RBXScriptConnection? = nil
    local generation = 0
    local self = {}
    local function stop()
        generation += 1
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
    function self.stop()
        stop()
    end
    function self.play(frames, looped: boolean?, onComplete: (() -> ())?)
        stop()
        if type(frames) ~= "table" or #frames == 0 then
            imageLabel.Image = ""
            imageLabel.Visible = false
            return false
        end
        for _, frame in ipairs(frames) do
            if type(frame.image) ~= "string" or type(frame.duration) ~= "number"
                or frame.duration <= 0 or frame.duration ~= frame.duration then
                error("Invalid sprite frame: image must be a string and duration must be positive")
            end
        end
        local token = generation
        local index = 1
        local elapsed = 0
        local function display()
            local frame = frames[index]
            imageLabel.Image = frame.image
            imageLabel.ImageTransparency = math.clamp(frame.transparency or 0, 0, 1)
            imageLabel.Visible = frame.image ~= ""
        end
        display()
        connection = RunService.RenderStepped:Connect(function(dt)
            if generation ~= token then return end
            elapsed += math.max(0, dt)
            -- Catch up after low-FPS frames without losing animation time.
            while elapsed >= frames[index].duration do
                elapsed -= frames[index].duration
                index += 1
                if index > #frames then
                    if looped then
                        index = 1
                    else
                        stop()
                        if onComplete then onComplete() end
                        return
                    end
                end
            end
            display()
        end)
        return true
    end
    function self.destroy()
        stop()
        imageLabel.Image = ""
        imageLabel.Visible = false
    end
    return self
end
return table.freeze(SpriteSequencePlayer)
