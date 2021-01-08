local Roact = require(script.Parent.Parent.Roact)
local Frame = Roact.PureComponent:extend("Frame")

function Frame:init()
end

function Frame:render()
	return Roact.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.907249153, 0, 0.91719538, 0),
		Size = UDim2.new(0.115499727, 0, 0.0796964094, 0),
	}, {
		Roact.createElement("Frame", {
			Name = "Burrito",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.485595107, 0, 0.487754226, 0),
			Rotation = 20,
			Size = UDim2.new(0.309597522, 0, 0.819672167, 0),
		}, {
			Roact.createElement("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.477799565, 0, 0.494648337, 0),
				Rotation = 20,
				Size = UDim2.new(1.00683856, 0, 1.00683856, 0),
				Image = "rbxassetid://6148760874",
			}),
			Roact.createElement("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.483897269, 0, 0.496867776, 0),
				Rotation = 20,
				Size = UDim2.new(1.00683856, 0, 1.00683856, 0),
				ZIndex = 0,
				Image = "rbxassetid://6148760874",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.5,
			})
		}),
		Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 2.6475410461426,
		}),
		Roact.createElement("TextButton", {
			Name = "Btn",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.297213525, 0, 0.00819664914, 0),
			Size = UDim2.new(0.619195044, 0, 0.975409925, 0),
			ZIndex = 5,
			Font = Enum.Font.SourceSans,
			Text = " ",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14,
		}),
		Roact.createElement("TextLabel", {
			Name = "Cash",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.516406, 0, 0.188524038, 0),
			Size = UDim2.new(0.448916376, 0, 0.614754081, 0),
			ZIndex = 0,
			Font = Enum.Font.SourceSans,
			RichText = true,
			Text = "<i>9M</i>",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(250, 250, 250),
			TextStrokeTransparency = 0.5,
			TextWrapped = true,
		})
	})
end

return Frame