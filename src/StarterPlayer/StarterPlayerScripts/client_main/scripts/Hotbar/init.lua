
return function ()
       
        local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
        local ItemHandler = require(ReplicatedStorage.item_handler)
        local HttpService = game:GetService("HttpService")
        local first_time_rendering = false
        local Player = Players.LocalPlayer
        local pgui = Player.PlayerGui
        local hotbar_viewport
        local ViewportHandler = require(ReplicatedStorage.Viewport)
        local Module3D = require(game.ReplicatedStorage:WaitForChild("Module3D"))
        local slots = {}
        function RenderHotbar()
            for i,Slot in pairs(pgui.Hotbar_Inventory.Hotbar:GetChildren()) do
                coroutine.wrap(function()
                    
                    if Slot:IsA("Frame") then
                        --Slot.inner.ViewportFrame:Destroy()
                        print(Slot.Name)
                        
                                print 'hello!'
                                local ViewportFrame = Instance.new("ViewportFrame")
                                ViewportFrame.BackgroundTransparency = 1
                                ViewportFrame.Parent = Slot.inner
                                wait()
                                local offset = CFrame.new(0,9,0)
                                --ReplicatedStorage.Items.Misc.Book.Model:Clone()
                                local ItemMain = ItemHandler:GetItemFromName("Book"):Clone()
                                local Item = ItemMain.Model
                                local orientation, size = Item:GetBoundingBox()
                                Item.Parent = ViewportFrame
                                Item:SetPrimaryPartCFrame (offset)
                                
                                wait()

                                Item.PrimaryPart.Anchored = true
                                
                                local Camera = Instance.new("Camera")
                                ViewportFrame.CurrentCamera = Camera
                                ViewportFrame.Size = UDim2.new(1,0,1,0)
                                Camera.Parent = ViewportFrame
                                local z_of = size.Magnitude*1.135
                                print(z_of)
                                Camera.CFrame = CFrame.new(Vector3.new(-2,offset.Position.Y + 1,4-(z_of)),Item.PrimaryPart.Position)

                                
                                
                        
                    end
             end)()
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
    wait(1)
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