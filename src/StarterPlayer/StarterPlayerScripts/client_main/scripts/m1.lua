return function()
	
	local function DOORTWEEN(value)
		local door = workspace.Door.MainPart.PrimaryPart
		local cfv = game.ReplicatedStorage:FindFirstChild("v"..value).Value
	
		game:GetService("TweenService"):Create(door,TweenInfo.new(1,Enum.EasingStyle.Elastic),{CFrame = cfv})	:Play()
	end
	local ZonePlus = game:GetService("ReplicatedStorage"):WaitForChild("HDAdmin"):WaitForChild("Zone+")
	local ZoneService = require(ZonePlus.ZoneService)
	local group = workspace.Zone1
	local zone = ZoneService:createZone("DoorZone", group, 15)
	local localPlayer = game:GetService("Players").LocalPlayer

	local isClientInZone = zone:getPlayer(localPlayer) -- Checks whether the local player is within the zone

	zone.playerAdded:Connect(function() -- Fires when the localPlayer enters the zone
		DOORTWEEN("2")
	end)
	zone.playerRemoving:Connect(function()  -- Fires when the localPlayer exits the zone
		DOORTWEEN("1")
	end)
	zone:initClientLoop() -- Initiates loop (default 0.5) which *only* checks for the local player, enabling events to work
end
