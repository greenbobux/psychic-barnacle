local module = {}
local Indexes = {}
function GetDirectory(userdata)
	local Directory = ""
	local CurrentDirectory = userdata

	repeat
		wait()
		CurrentDirectory = CurrentDirectory.Parent
		Directory = CurrentDirectory.Name..Directory
		print(CurrentDirectory)
	until CurrentDirectory == game
	return Directory
end
function module:Wrap(userdata)
	local Object = {}
	local Properties = {
		Directory = GetDirectory(userdata)
	}
	for i,v in pairs(Properties) do
		Object[i] = v
	end

	return Object
end
function module:GetIndexes()
	return Indexes
end
-- hey.
return module

