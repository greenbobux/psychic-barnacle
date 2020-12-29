local TweenService = game:GetService("TweenService")
local __table = {
	{alias = {"default","Default"}; type = "Notifaction"; Positioning = "Top-center" };
	{alias = {"Fade";"Transition"}; type = "Frame"; Positioning = "Center"; extra_data = {};
	main = function(Arguments)
		local Player = game.Players.LocalPlayer
		local P_UI = Player.PlayerGui
		local Settings = Arguments
		print(settings)
		local FadeTime,DesiredTransparency,DesiredColor = Settings.FadeTime,Settings.Desired.Transparency,Settings.Desired.Color
		local Frame =  game.ReplicatedStorage.UI_effects.f1:Clone()
		Frame.Parent = P_UI.INTERFACE_EFFECTS
		Frame.BackgroundColor3 = DesiredColor
		Frame.Transparency = Settings.Default.Transparency
		TweenService:Create(Frame,TweenInfo.new(FadeTime),{Transparency = DesiredTransparency}):Play()
		return Frame,Settings
	end}

}
function await(parent,n)
	return parent:WaitForChild(n)
end

setmetatable(__table,{
	__index = function(tbl,index)
		local Type = nil
		local tabl
		for i,v in pairs(tbl) do
			if v.type == index then
				Type = v.Type
				tabl = v
			end
		end
		for _,v in pairs(__table) do
			for _,k in pairs(v.alias) do
				if index == k then
					Type = v.Type
					tabl = v
				end
			end
		end
		--     local extradata = tbl.extra_data_ or {}

		return tabl
	end;
})

return __table