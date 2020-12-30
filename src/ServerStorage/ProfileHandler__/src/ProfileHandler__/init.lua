local module = {}
module.New = require(script.new.modules.main)
module.Set = require(script.set.modules.main)
module.Get = require(script.get.modules.main)
setmetatable(module,{
	__index = function(tbl,i)
		local found
		for z,v in pairs(tbl) do
			if z:lower() == i:lower() then
				found = v
			end
		end
		return found
	end
})
return module
