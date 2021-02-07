return function (input)
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService,LocalPlayer = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService"),game.Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local ItemNameValue = Character.Values.Slot.ItemName.Value
    if ItemNameValue ~= "" or nil then
        local item = require(game:GetService("ReplicatedStorage").item_handler):GetItemFromName(ItemNameValue)
        if item:FindFirstChild("events") then
            local client = item.events:FindFirstChild("client")
            if not client then return end
            client = require(client)
            local InputHandle = client.InputHandler
            local Main = client.Main

            for i,v in pairs(InputHandle) do
                if input.Input == v then
                    if Main[i] then
                        Main[i]()
                    end
                    
                end
            end
        
        end
    end
end