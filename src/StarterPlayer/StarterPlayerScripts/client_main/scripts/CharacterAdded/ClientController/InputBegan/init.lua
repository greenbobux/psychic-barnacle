local KeyEvents = {}
for i,v in pairs(script.KeyEvents:GetChildren()) do
	if v:IsA("ModuleScript") then
		KeyEvents[v.Name] = require(v)
	end
end
local Hitbox = require(game.ReplicatedStorage.RaycastHitboxV3)
return function(input,gamp,animation)
	if gamp then return end
	if script:FindFirstAncestorOfClass("PlayerScripts").Values.DisableViewportArmActions.Value == true then return end
	local IsKeyboard = false
	
	local KeyCode = {str = ""; enum = "";}
	local UserInputType = input.UserInputType
	IsKeyboard = UserInputType == Enum.UserInputType.Keyboard
	if IsKeyboard then KeyCode["str"] = input.KeyCode.Name; KeyCode["enum"] = input.KeyCode; end
	if UserInputType.Name:sub(1,5):lower() == "mouse" then KeyCode["str"] = input.UserInputType.Name; KeyCode["enum"] = input.UserInputType; end

	local event
	for i,v in pairs(KeyEvents) do
	
		if v.Key == KeyCode["str"] then
			event = v
		end
	end
	if event then
		event:Client()
	end
	
end