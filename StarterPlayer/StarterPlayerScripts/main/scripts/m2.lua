return function()
	
	local ZonePlus = game:GetService("ReplicatedStorage"):WaitForChild("HDAdmin"):WaitForChild("Zone+")
	local ZoneService = require(ZonePlus.ZoneService)
	local group = workspace.Zone2
	local zone = ZoneService:createZone("DoorZone", group, 15)
	local localPlayer = game:GetService("Players").LocalPlayer

	local isClientInZone = zone:getPlayer(localPlayer) -- Checks whether the local player is within the zone

	zone.playerAdded:Connect(function() -- Fires when the localPlayer enters the zone
		
	end)
end
