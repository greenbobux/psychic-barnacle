local module = {
	Key = "MouseButton1";
	CoolDown = 1;
	{Limbs = "Right Arm"};
	DamageData = {
		Damage = 10;
	};
	
	Client = function(self)
		local a = workspace.viewModel.AnimationController
		a = a:LoadAnimation(a.Punch)
		a:Play()
		local a = game.Players.LocalPlayer.Character.Humanoid
		a = a:LoadAnimation(script.Animation)
		a:Play()
	end
}


return module
