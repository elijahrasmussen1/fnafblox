--!strict
-- Top-level screen state machine. All views are Roblox GUI; 3D camera remains fixed.
local MenuController = require(script.Parent:WaitForChild("MenuController"))
local AppController = {}
function AppController.create(gui: ScreenGui, onGameStart: (number) -> ())
    local state = "title"
    local menu
    local controller = {}
    local function startNight(night: number)
        if state ~= "title" then return end
        state = "gameplay"
        menu.hide()
        onGameStart(night)
    end
    menu = MenuController.create(gui, startNight)
    function controller.getState()
        return state
    end
    function controller.returnToTitle()
        state = "title"
        menu.show()
    end
    function controller.destroy()
        menu.destroy()
    end
    return controller
end
return table.freeze(AppController)
