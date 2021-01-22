return function()
	wait()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local camera = game.Workspace.CurrentCamera;
	local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
	local UserInput = game:GetService("UserInputService")
	local viewModel = game.ReplicatedStorage:WaitForChild("viewModel"):Clone();
	viewModel.Parent = workspace
	print(viewModel.Parent.Name)
	local AnimationPlayer = require(script.AnimationPlayer).new(humanoid)
	
	local AnimationViewmodel = require(script.AnimationPlayer).new(workspace:WaitForChild("viewModel").AnimationController)
	wait(.1)



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
		viewModel.HumanoidRootPart.CFrame = camera.CFrame*CFrame.new(0,-1,0);
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
		AnimationViewmodel.LoadAnimation(v,false)
	end
	game.ReplicatedStorage.Bindables.PlayViewportAnimation.OnInvoke = function(animation)
		AnimationViewmodel.LoadAnimation(animation,true)
	end
end