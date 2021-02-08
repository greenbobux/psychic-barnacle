--[[
IsKeyboard = IsKeyboard;
IsMouse = IsMouse;
Input = IsMouse and UIT or IsKeyboard and KC;

]]
return function(Input)
    local PreviousAnim 
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local ItemHandler,DataHandler = require( ReplicatedStorage.item_handler), require( ReplicatedStorage.DataHandleModule)
    local Animation = require ( ReplicatedStorage.AnimationHandler )
    local Animator = Animation:new(workspace.viewModel.AnimationController)
    local PlayerGui,Character = LocalPlayer:WaitForChild("PlayerGui"), LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local tbl = {
            "one";
            "two";
            "three";
            "four";
            "five";
            "six";
            "seven";
        }
    local number_name = Input.Input.Name
    local index = nil 
    for i,v in pairs(tbl) do
        if v == number_name:lower() then
            index = i
        end
    end
    if index then
        
    end
    local ItemName = DataHandler.Client.Cache.Inventory.Hotbar[index]
    if index == Character.Values.Slot.Value then 
            if PreviousAnim then 
                PreviousAnim:Stop() 
            end 
        Animator:EndAnimation("Itemhold") 
        local item = require(game:GetService("ReplicatedStorage").item_handler):GetItemFromName(ItemName)
        if item:FindFirstChild("events") then
            local client = item.events:FindFirstChild("client")
            if client then
                client = require(client)
                if client.Main.Unequipped then
                    coroutine.wrap(client.Main.Unequipped)()
                    ReplicatedStorage.Remotes.Items.Binds.Unequipped:Invoke(client)
                end
            end
        end
        workspace.viewModel.ItemModel:Destroy() 
        Character.Values.Slot.Value = 0; 
        Character.Values.Slot.ItemName.Value = "" 
        return 
    end

    if ItemName then
        Character.Values.Slot.Value = index
        Character.Values.Slot.ItemName.Value = ItemName
        local Item = ItemHandler:GetItemFromName(ItemName)
        if workspace:FindFirstChild("viewModel"):FindFirstChild("ItemModel") then workspace.viewModel.ItemModel:Destroy() end
        if not Item then return end

        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local ItemNameValue = Character.Values.Slot.ItemName.Value
        if ItemNameValue ~= "" or nil then
            local item = require(game:GetService("ReplicatedStorage").item_handler):GetItemFromName(ItemNameValue)
            if item:FindFirstChild("events") then
                local client = item.events:FindFirstChild("client")
                if client then
                    client = require(client)
                    if client.Main.Equipped then
                        
                        coroutine.wrap(client.Main.Equipped)()
                        ReplicatedStorage.Remotes.Items.Binds.Equipped:Invoke(client)
                    end
                end
            end
        end

        local ItemClone = Item:Clone()
        local ItemModel = ItemClone.Model
        for i,v in pairs(ItemModel:GetDescendants()) do
            if v:IsA("BasePart") then v.Anchored = false; v.CanCollide = false; end
        end
        local Motor6D = Instance.new("Motor6D")
        Motor6D.Parent = workspace.viewModel["Right Arm"]
        Motor6D.Part0 = Motor6D.Parent
        ItemModel.Name = "ItemModel"
        for i,v in pairs(ItemModel:GetDescendants()) do if v:IsA("BasePart") then v.Size *= .5 end end
        Motor6D.Part1 = ItemModel.PrimaryPart
        ItemModel.Parent = workspace.viewModel
        PreviousAnim = Animator:LoadAnimation(ReplicatedStorage.Animations.Itemhold,{PlayAnimations = true;})
        
    end

    ReplicatedStorage.Remotes.Items.Binds.Unequipped.OnInvoke = function(client)
        local settings = client.Settings
        if settings.ToggleMouseLock then
            PlayerGui.ui.lock.Modal = false
        end
    end

    ReplicatedStorage.Remotes.Items.Binds.Equipped.OnInvoke = function(client)
        local settings = client.Settings
        if settings.ToggleMouseLock then
            PlayerGui.ui.lock.Modal = true
        end
    end
end

