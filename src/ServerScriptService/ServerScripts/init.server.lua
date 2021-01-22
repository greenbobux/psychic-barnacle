local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
local ServerScripts = script.ServerModules

function ParseDirectory(str)
	local tbl = string.split(str,".")
	local CurrentDirectory = ReplicatedStorage.Remotes
	for i,v in pairs(tbl) do
		local Canadate = CurrentDirectory[v]
		if Canadate then
			CurrentDirectory = Canadate
		end
		if i == #tbl then
			return CurrentDirectory
		end
	end
end

for _,Script in pairs(ServerScripts:GetChildren()) do
    if Script:IsA("ModuleScript") then
        local s,e = pcall(function()
			require(Script)()
		end)
		if e then
			warn(s)
		end
    end
end

local Remotes = {}
local function Remote(module)
		local contents = require(module)
		local dir = ParseDirectory(module.Name)
		local hasMethod = #contents == 2
		local method = contents[2] or "OnServerEvent"
		print ( dir.ClassName:sub(1,6) )
	Remotes[module.Name] = {
		FUNCTION = contents[1];
		RBX_SCRIPT_SIGNAL = ( dir.ClassName:sub(1,6) == "Remote" and module[method]:Connect(contents[1]) ) or "Callback"
	}
end
for i,v in pairs(ServerScripts.Remotes:GetChildren()) do
	if v:IsA("ModuleScript") then Remote(v) end
end