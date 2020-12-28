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
		if #selection > 0 then
			local last = selection[1]

			for _,v in pairs(selection) do
				if (v:IsA("BasePart")) then
					if (last) then

						local w = Instance.new("Weld")
						w.Name = ("%s_Weld"):format(v.Name)
						w.Part0,w.Part1 = last,v
						w.C0 = last.CFrame:inverse()
						w.C1 = v.CFrame:inverse()
						w.Parent = last
					end
					last = v
				end
			end	
		end
	end
end)