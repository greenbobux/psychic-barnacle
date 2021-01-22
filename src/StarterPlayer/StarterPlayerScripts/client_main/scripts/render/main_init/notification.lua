-- notification
-- green/devtychi
-- January 19, 2021


local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui,Character = LocalPlayer:WaitForChild("PlayerGui"), LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local notification = {}
local notificationlib = require(    ReplicatedStorage.Notifications    )
function ParseDirectory(parent,text)
    local Directory = text:split(".")
    local FinalDirectory
    local CurrentDirectory = parent
        for i,Parsed in pairs(Directory) do
            local Canidate_Dir = CurrentDirectory:FindFirstChild(Parsed)
            if Canidate_Dir then
                CurrentDirectory = Canidate_Dir
            end
        end
    return CurrentDirectory
end
notification.Function = function(params)
    local TopCenter = notificationlib.Types:New("TopCenter")
    local Pos_TC = TopCenter.Positioning -- tc means top center
    local notification_ui = notificationlib.UI.types["notification_header"]:Clone()
    notification_ui.Parent = PlayerGui.Notifications.TopCenter
    if params.TweenData then
        local params2 = params.TweenData
        local Directory,TWEENINFO,properties = params2.DIRECTORY,params2.TWEENINFO, params2.PROPERTIES
        print(Directory,TWEENINFO,properties)
        TweenService:Create(ParseDirectory(notification_ui,Directory), TweenInfo.new( TWEENINFO ), properties):Play()
    end
    delay(params.Lifetime or 1,function()
        notification_ui:Destroy()
    end)
    notification_ui.TextLabel.Text = params.Text
end

return notification