local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
return function (module)

    local s,e = pcall(function()
        module()
    end)

    if e then
        warn(e)
    end
end 