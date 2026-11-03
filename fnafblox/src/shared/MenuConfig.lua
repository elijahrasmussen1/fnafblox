--!strict
-- Menu flow is provisional until Clickteam frame/event rules are extracted.
return table.freeze({
    title = "Five Nights at Freddy's",
    buttons = {"New Game", "Continue", "Options", "Credits"},
    -- Each imported frame: {image = "rbxassetid://123", duration = 0.1}.
    -- No placeholders are presented as original artwork.
    artFrames = {
        {image = "rbxassetid://120282870722776", duration = 1},
    },
    initialNight = 1,
    maxNight = 5,
})
