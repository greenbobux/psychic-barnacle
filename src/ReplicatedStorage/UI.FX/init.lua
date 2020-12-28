local UI = {}
function await(parent,name)
    return parent:WaitForChild(name)
end
    function UI.new()
        local Player = game.Players.LocalPlayer
        local Plr = {
            Player = Player;
            Character = Player.CharacterAdded:Wait() or Player.Character;
            PlayerGui = await(Player,"PlayerGui")
        }
        local OBJ = {
        
        }
        
        OBJ.UI_LIST = {}
        
        return OBJ
    end

return UI