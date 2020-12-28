local http = game:GetService("HttpService")
local req = http:GetAsync("https://api.github.com/repos/Roblox/StudioWidgets/contents/src")
local json = http:JSONDecode(req)

local WidgetAddOns = Instance.new("Folder")
WidgetAddOns.Name = "StudioWidgets"

for i = 1, #json do
	local file = json[i]
	if (file.type == "file") then
		local name = file.name:sub(1, #file.name-4)
		local module = Instance.new("ModuleScript")
		module.Name = name
		module.Source = http:GetAsync(file.download_url)
		module.Parent = WidgetAddOns
	end
end

local module = {}
function module.new()
	local Object = {}
	function Object:GenerateButtons(widget)
		local bgframe = Instance.new("Frame")
		bgframe.Parent = widget
		bgframe.Size = UDim2.new(1,0,1,0)
		require(WidgetAddOns.GuiUtilities).syncGuiElementBackgroundColor(bgframe)

		local button = require(WidgetAddOns.CustomTextButton).new("anchor", "Anchor Objects")
		local buttonObject = button:GetButton()
		buttonObject.Size = UDim2.new(0,200,0,50)
		buttonObject.TextLabel.TextColor3 = Color3.new(1,1,1)
		buttonObject.Parent = bgframe
		buttonObject.Position = UDim2.new(0.5,-100,0.5,-25)
	end
end


return module