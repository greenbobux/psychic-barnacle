local widgetInfo  = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, --This can be changed--
	false,
	false,
	200,
	200,
	150,
	150)
local widget = plugin:CreateDockWidgetPluginGui("Weld Plugin", widgetInfo)
widget.Title = "Weld Plugin"

--[[
	TOGGLING THE WIDGET
]]

local toolbar = plugin:CreateToolbar("Weld Plugin")
local toggle = toolbar:CreateButton("Toggle Widget", "Toggle the widget", "")

toggle.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)



--[[
	BUTTONS
]]

local AddOns = require(script.AddOns):GenerateButtons(widget)

widget.Frame.Weld.MouseButton1Down:Connect(function()
	local selection = game:GetService("Selection"):Get()
	if selection then
		for x,e in pairs(selection) do
			for i,v in pairs(e:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Anchored = true
				end
			end
			if e:IsA("BasePart") then
				e.Anchored = true
			end
		end
	end
end)