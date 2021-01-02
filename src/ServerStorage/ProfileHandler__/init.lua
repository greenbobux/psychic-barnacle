local module = {
	new = nil;
	get = nil;
	set = nil;
}
function smartrequire(module,table)
	local module = require(module)
	module.util = table
	return module
end
for i, v in pairs(module) do
	local folder = script:FindFirstChild(i) 
	do
		module[i] = smartrequire(folder.moduels.main)
	end
end
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
