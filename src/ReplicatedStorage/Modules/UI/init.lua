local ui = {}; 
local TweenService = game:GetService("TweenService")
local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")

local types = {
    Fade = {Main = function(self,args)
        local settings,frame = args
        frame = frame or ReplicatedStorage.UI_effects.f1:Clone()
        frame.Parent = Players.LocalPlayer.PlayerGui.ui
        local Desired = settings.Desired or {Transparency=1,BackgroundColor3=Color3.fromRGB(0, 0, 0), Time = 2}
        local Default = settings.Default or {Transparency = 0,BackgroundColor3 = Color3.fromHSV(0,0,0)}
        
        for i,v in pairs(Default) do
            if frame[i] then
                frame[i] = v
            end
        end
        local tweens = {}
        local time = TweenInfo.new(Desired.Time)
        Desired["Time"] = nil
        return  TweenService:Create(frame,time,Desired):Play(),frame
    end}
}
for i,v in pairs(types) do
    if v.Main then
        setmetatable(v, { __call = v.Main; __newindex = function()
            return "read only"
        end})
        
    end
end
function ui.new()
    local constructor
    constructor = {}
    
    function constructor.Type(str)
        return types[str] ~= nil and types[str]
    end
    return constructor 
end
return ui