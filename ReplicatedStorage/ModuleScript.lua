local module = {}
local Indexes = {}
function GetDirectory(userdata)
	local Directory = ""
	local CurrentDirectory = userdata

	repeat
		wait()
		CurrentDirectory = CurrentDirectory.Parent
		Directory = CurrentDirectory.Name..Directory
	until CurrentDirectory == game
end
function module:Wrap(userdata)
	local Object = {}
	local Properties = {}
	for i,v in pairs(Properties) do
		Object[i] = pcall return userdata[v] or v
	end
	return Object
end
function module:GetIndexes()
	return Indexes
end
return module
