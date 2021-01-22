local module = {}
module.Animations = {}
module.new = function(object)
	local obj = {}
	obj.Controller = obj
	obj.Animations = {}
	obj.LoadAnimation = function(animation,playAnimationAswell)
		if not module.Animations[animation.Name] then
			module.Animations[animation.Name]  =  object:LoadAnimation(animation)
		end
		if playAnimationAswell then
			obj.PlayAnimation(animation.Name)
		end
		return module.Animations[animation.Name] 
	end
	obj.PlayAnimation = function(name)
		if module.Animations[name] then
			module.Animations[name]:Play()
		end
	end
	return obj
end

return module
