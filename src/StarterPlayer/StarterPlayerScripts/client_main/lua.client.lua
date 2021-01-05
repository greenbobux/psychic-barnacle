local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local first_time_rendering = false
local Player = Players.LocalPlayer
local pgui = Player.PlayerGui
local hotbar_viewport
local ViewportHandler = require(ReplicatedStorage.Viewport)


function RenderHotbar()
    for _,Slot in pairs(pgui.Hotbar_Inventory.Hotbar:GetChildren()) do
        print(Slot.Name)
        if Slot:IsA("Frame") then
            coroutine.wrap (function()
                local frame = script.viewport:Clone()
                frame.Parent = Slot.Inner
                local VF_Handler = ViewportHandler.new(frame)
                VF_Handler:RenderObject(workspace.Part)
            end)()
        end
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

    local total_seconds = 0
    wait(2)
    RenderHotbar()

