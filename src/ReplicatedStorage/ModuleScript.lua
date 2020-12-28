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

	return userdata
end
function module:GetIndexes()
	return Indexes
end
return module
-- hello
