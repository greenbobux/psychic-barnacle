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
		coroutine.wrap(v)()
	end
end
local LocalPlayer = game.Players.LocalPlayer

LocalPlayer.CharacterAdded:Connect(function()
	wait()
	print("char added")
	run(char_added)
end)
local Character = LocalPlayer.CharacterAdded:Wait() or LocalPlayer.CharacterAdded
local function blank()
	
end
local fenv = {
	ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService");
	
}
for i,v in pairs(getfenv(0)) do
	fenv[i] = v
end
local Funcs = {
	ms = function(ms_instance)
		local func = require(ms_instance)
		
		local S,E = pcall(function()
			coroutine.wrap(function()
				func()
			end)()
		end)
		
		return S and S, E and E
	end
}

function Loop_Modules(parent)
	for i,v in pairs(parent and parent:GetChildren() or script.scripts:GetChildren()) do
		if v:IsA("ModuleScript") then
			if v:FindFirstChild("Disable") then continue end
			local success, error = Funcs.ms(v)
			--warn(success and success, error and error)
			elseif v:IsA("Folder") and v.Name ~="CharacterAdded" then
				local MODULE_MAIN = v:FindFirstChild("main_init")
				if MODULE_MAIN then MODULE_MAIN = require(MODULE_MAIN) else Loop_Modules(v)  end
				if MODULE_MAIN then 
					coroutine.wrap(MODULE_MAIN)()
				end
		end
	end
end

Loop_Modules()




--local TestService = game:GetService("TestService")
