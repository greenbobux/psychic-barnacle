return function ()
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui,Character = LocalPlayer:WaitForChild("PlayerGui"), LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        ReplicatedStorage.Remotes.FireBindable.OnClientEvent:Connect(function(bindable,...)
            bindable:Invoke(...)
        end)
end