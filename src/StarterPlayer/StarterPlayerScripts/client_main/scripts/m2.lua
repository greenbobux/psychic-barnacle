return function()
	local ZonePlus = game:GetService("ReplicatedStorage"):WaitForChild("HDAdmin"):WaitForChild("Zone+")
	local ZoneService = require(ZonePlus.ZoneService)
	local group = workspace.Zone2
	local zone = ZoneService:createZone("DoorZone2", group, 15)
	local localPlayer = game:GetService("Players").LocalPlayer
	
	local isClientInZone = zone:getPlayer(localPlayer) -- Checks whether the local player is within the zone
	local Module = require(game.ReplicatedStorage["UI"]).new()
	

	zone.playerAdded:Connect(function() -- Fires when the localPlayer enters the zone
		localPlayer.Character.HumanoidRootPart.Anchored = true
		print("hello")
		local frame,settings = Module.Create(Module.NewType.Frame)
		wait(settings.FadeTime)
		frame:Destroy()
		localPlayer.Character.HumanoidRootPart.CFrame = workspace.objects.p1.CFrame
		local frame = Module.Create(Module.NewType.Frame,Module.Body())
		delay(settings.FadeTime+.5,function()
			localPlayer.Character.HumanoidRootPart.Anchored = false
		end)
	--	Module.Create(Module.NewType.Frame)
	end)
	zone:initClientLoop()
end
