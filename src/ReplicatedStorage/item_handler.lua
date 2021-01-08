local tbl = {}

local ReplicatedStorage,ServerStorage,Players,TweenService,RunService,HttpService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService"),game:GetService("HttpService")

function Encode(string)
    return HttpService:JSONEncode(string)
end

function Decode(string)
    return HttpService:JSONDecode(string)
end

tbl.data = {ITEM_COUNT = 0}
tbl.ItemDirectory = ReplicatedStorage.Items
function tbl.GetItemFromName(self,name)
    for i,v in pairs(self.ItemDirectory:GetDescendants()) do
        local item_data = v.Name == "ItemData" and Decode(v.Value)
        if not item_data then continue end
        if item_data.ItemName ~= name then continue end
        return v.Parent
    end
end

function tbl.GetItemCount(self)
	local count = 0
    for i,v in pairs(self.ItemDirectory:GetDescendants()) do
        if v.Name ~= "ItemData" then continue end
		count+=1;
	end
	tbl.data.ITEM_COUNT = count
	return count
end

return tbl