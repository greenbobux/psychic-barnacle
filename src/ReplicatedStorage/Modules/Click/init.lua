local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end
local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")

local Click = {}
function  Click.new(BasePart)
    if not BasePart:IsA("BasePart") then return end
    local Identifier = Instance.new ("StringValue")
    Identifier.Value = uuid
    Identifier.Name = "uuid"
    Instance.Parent = BasePart
end
    
endClick.new()
return Click