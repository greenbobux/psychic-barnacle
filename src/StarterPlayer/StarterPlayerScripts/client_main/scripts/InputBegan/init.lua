return function()
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
    local Player = {
    } 
    local ContextActionService = game:GetService("ContextActionService")
    setmetatable(Player,{
        __index = function(tbl,i)
            if Players.LocalPlayer[i] then
                return Players.LocalPlayer[i]
            else
                return tbl[i]
            end;
        end;
        __newindex= function(tbl,i,v)
            if Players.LocalPlayer[i] then
            Players.LocalPlayer[i] = v
            else
                tbl[i] = v
            end;
        end;
    })
    local Events = {}
    local Keybinds = {}
    local function HandleAction(Action,UserInputState,InputObject)
        local Event = Events[Action]
        if Event then Event(require(ReplicatedStorage.input)(InputObject)) end
    end
    for _,m in pairs(script.Events:GetChildren()) do
        Events[m.Name] = require(m)
    end
    for _,m in pairs(script.Keybinds:GetChildren()) do
        Keybinds[m.Name] = require(m)
        m = require(m)
        ContextActionService:BindAction(m.onEvent,HandleAction,false,unpack(m.keys))
    end
end