
return function ()
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local first_time_rendering = false
local Player = Players.LocalPlayer
local pgui = Player.PlayerGui
local hotbar_viewport
local ViewportHandler = require(ReplicatedStorage.Viewport)
local Module3D = require(game.ReplicatedStorage:WaitForChild("Module3D"))

function RenderHotbar()
    for _,Slot in pairs(pgui.Hotbar_Inventory.Hotbar:GetChildren()) do
      
        if Slot:IsA("Frame") then
            print(Slot.Name)
             
                  
                    local ViewportFrame = Instance.new("ViewportFrame")
                    ViewportFrame.BackgroundTransparency = 1
                    ViewportFrame.Parent = Slot.inner

                    local Item = ReplicatedStorage.Part:Clone()
                    Item.Parent = ViewportFrame
                    Item.Anchored = true
                    Item.Position = Vector3.new(0,0,0)
                    local Camera = Instance.new("Camera")
                    ViewportFrame.CurrentCamera = Camera
                    ViewportFrame.Size = UDim2.new(1,0,1,0)
                    Camera.Parent = ViewportFrame

                    Camera.CFrame = CFrame.new(Vector3.new(0,1,4),Item.Position)

                    
                    
            
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
    wait(3)
    RenderHotbar()

   
    --[[
    RunService.Heartbeat:Connect(function(delta)
        total_seconds += delta
        if total_seconds >= .1 then
            render()
            total_seconds = 0
        end
    end)
    ]]
end