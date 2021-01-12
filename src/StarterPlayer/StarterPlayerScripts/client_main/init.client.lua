local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
local LocalPlayere = {
		CharacterAdded = {Connect = function(self,func)
			workspace.ChildAdded:Connect(function(child)
				if child.Name == Players.LocalPlayer.Name then
					return child
				end
			end)
		end;
		Wait = function(self)
			repeat
				wait()
			until workspace:FindFirstChild(Players.LocalPlayer.Name)
			return workspace:FindFirstChild(Players.LocalPlayer.Name)
		end
	}
}
local char_added = {}
for i,v in pairs(script.scripts.CharacterAdded:GetChildren()) do
	char_added[v.Name] = require(v)
end
function  run(table)
	for i,v in pairs(table) do
		v()
	end
end
local LocalPlayer = game.Players.LocalPlayer

LocalPlayer.CharacterAdded:Connect(function()
	print("char added")
	run(char_added)
end)
local Character = LocalPlayer.CharacterAdded:Wait() or LocalPlayer.CharacterAdded
local function blank()
	
end
local fenv = {
	ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService");
	
}
local Funcs = {
	ms = function(ms_instance)
		local func = require(ms_instance)
		--setfenv(func,fenv)
		local S,E = pcall(func)
		
		return S and S, E and E
	end
}

for i,v in pairs(script.scripts:GetChildren()) do
	if v:IsA("ModuleScript") then
		local success, error = Funcs.ms(v)
		--warn(success and success, error and error)
	end
end



--local TestService = game:GetService("TestService")
