return function()
	wait()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local camera = game.Workspace.CurrentCamera;
	local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
	local UserInput = game:GetService("UserInputService")
	local viewModel = game.ReplicatedStorage:WaitForChild("viewModel"):Clone()
	viewModel.Parent = workspace
	local AnimationController = viewModel.AnimationController
	wait(.1)

	local Animations = {
		viewModel = {};
	}


	viewModel["Right Arm"].BrickColor = humanoid.Parent["Right Arm"].BrickColor
	viewModel["Left Arm"].BrickColor = humanoid.Parent["Left Arm"].BrickColor
	local function onDied()
		viewModel.Parent = nil;
	end

	local function updateArm(key)
		-- get shoulder we are rotating
		local shoulder = viewModel["Torso"][key.." Shoulder"]
		-- calculate worldspace arm cframe from Right or Left part in the weapon model
		local cf = shoulder.C1 * CFrame.Angles(0, 0, 0) * CFrame.new(0, 1.5, 0);
		-- update the C1 value needed to for the arm to be at cf (do this by rearranging the joint equality from before)
		shoulder.C1 = cf:inverse() * shoulder.Part0.CFrame * shoulder.C0;

	end
	local remoteEvents = game.ReplicatedStorage:WaitForChild("Remotes");


	local function onUpdate(dt)
		viewModel.HumanoidRootPart.CFrame = camera.CFrame*CFrame.new(0,-.6,-.55) * CFrame.Angles(math.rad(-1.875),0,0);
		--remoteEvents.tiltAt:FireServer(math.asin(camera.CFrame.LookVector.y));
		-- update every frame so the arms stay in place when the player aims down sights
		--updateArm("Right");
		--updateArm("Left");
	end
	local con = game:GetService("RunService").RenderStepped:Connect(onUpdate);
	humanoid.Died:Connect(function()
		con:Disconnect()
		onDied()
	end)

	UserInput.InputBegan:Connect(function(input,gamp)
		require(script.InputBegan)(input,gamp,{
			PlayerAnimator = AnimationPlayer;
			viewModelAnimator = AnimationViewmodel;
		})
	end)

	for i,v in pairs(ReplicatedStorage.Animations:GetChildren()) do
		local animation_type = "character"
		if v:FindFirstChild("type") then
			animation_type = v.type.Value
		end
		if animation_type == "viewModel" then

		end
		if not Animations[animation_type] then Animations[animation_type] = {} end

		Animations[animation_type][v.Name] = AnimationController:LoadAnimation(v)
	end
	game.ReplicatedStorage.Bindables.PlayViewportAnimation.OnInvoke = function(animation)
		Animations.viewModel[animation.Name]:Play()
	end
end