local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local first_time_rendering = false
local Player = Players.LocalPlayer
local pgui = Player.PlayerGui
local viewport = require(ReplicatedStorage.Viewport)
local hotbar_viewport
function first_time ()
    local hotbar = {}
    for i,v in pairs(pgui["Hotbar_Inventory"]["Hotbar"]:GetChildren()) do
        hotbar[v.Name] = {viewport.new(v.inner)}
    end
    return hotbar
end
function render ()
    if not first_time_rendering then
        first_time_rendering = true
        hotbar_viewport = first_time()
    end
    for _,v in pairs(hotbar_viewport) do
        if v.obj_handler then
            v.obj_handler:Destroy()
        end
        
        local obj_handle = v:RenderObject(Object)
        v.obj_handler = obj_handle
        
    end
end
function GetItemFromName(name)
        local item = nil
            for i,v in pairs(game.ReplicatedStorage.Items:GetDescendants()) do
                if v.Name == name then
                    local IsItem = v:FindFirstChild("IsItem")
                        if IsItem then
                            return "Not an item!"
                        end
                        local ItemData = v:FindFirstChild("ItemData")
                        return HttpService:JSONDecode ( ItemData.Value );
                end
            end
end
return function ()
    local total_seconds = 0
    RunService.Heartbeat:Connect(function(delta)
        total_seconds += delta
        if total_seconds >= .1 then
            render()
            total_seconds = 0
        end
    end)
end