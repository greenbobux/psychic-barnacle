return function ()

local ZonePlus = game:GetService("ReplicatedStorage"):WaitForChild("HDAdmin"):WaitForChild("Zone+")
local ZoneService = require(ZonePlus.ZoneService)
local group = workspace.Zone2
local zone = ZoneService:createZone("DoorZone2", group, 15)
local localPlayer = game:GetService("Players").LocalPlayer
print "apples"
local isClientInZone = zone:getPlayer(localPlayer) -- Checks whether the local player is within the zone

zone.playerAdded:Connect(function() -- Fires when the localPlayer enters the zone
	local Module = require(game.ReplicatedStorage.Modules.UI).new()
	local FadeTime = 1
    localPlayer.Character.HumanoidRootPart.Anchored = true
		print("hello")
		local tween,frame = Module.Type("Fade")({
			Desired = {Transparency=0,BackgroundColor3=Color3.fromRGB(0, 0, 0), Time = FadeTime};
			Default = {Transparency = 1,BackgroundColor3 = Color3.fromHSV(0,0,0)};
		})

		wait(FadeTime)
		frame:Destroy()
		localPlayer.Character.HumanoidRootPart.CFrame = workspace.objects.p1.CFrame
		local tween,frame = Module.Type("Fade")({
			Desired = {Transparency=1,BackgroundColor3=Color3.fromRGB(0, 0, 0), Time = FadeTime};
			Default = {Transparency = 0,BackgroundColor3 = Color3.fromHSV(0,0,0)};
		})

		delay(FadeTime+.5,function()
			localPlayer.Character.HumanoidRootPart.Anchored = false
        end)
end)

zone:initClientLoop() -- Initiates loop (default 0.5) which *only* checks for the local player, enabling events to work
		
        
    end