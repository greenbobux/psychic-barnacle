local module = {}
module.new = function(object)
	local obj = {}
	obj.Controller = obj
	obj.Animations = {}
	obj.LoadAnimation = function(animation)
		if not obj.Animations[animation.Name] then
			obj.Animations[animation.Name]  =  obj.Controller:LoadAnimation(animation)
		end
		return obj.Animations[animation.Name] 
	end
	obj.PlayAnimation = function(name)
		if obj.Animations[name] then
			obj.Animations[name]:Play()
		end
	end
	return obj
end

setmetatable(module,{__mode="k"})
return module
