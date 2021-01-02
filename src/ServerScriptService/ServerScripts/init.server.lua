local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
local ServerScripts = script.ServerModules

for _,Script in pairs(ServerScripts:GetChildren()) do
    if Script:IsA("ModuleScript") then
        require(Script)()
    end
end