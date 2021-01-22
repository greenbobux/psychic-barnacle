-- rendermain
-- green/devtychi
-- January 18, 2021



return function ()
    local FunctionsToExecute = {}
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")

    for i,module in pairs(script:GetChildren()) do
        local isModule = module:IsA("ModuleScript")
        local ModuleContent = isModule and require(module)
        local DataType = (ModuleContent.Function and 1) or 2 -- do this so i can intergrate other settings
        
            
        if isModule then
            FunctionsToExecute[module.Name] = ( DataType == 1 ) and ModuleContent.Function or ModuleContent
        end

    end
    ReplicatedStorage.Remotes.Render.OnClientEvent:Connect(function(data)
        local Render_Type,RenderParams = data.Type,data.Params
        local RenderFunction = FunctionsToExecute[Render_Type]
        if RenderFunction then
            RenderFunction(RenderParams)
        end
    end)
end