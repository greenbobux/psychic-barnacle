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
function tbl:GetItemFromName(name)
    if name == "none" then return end
    for i,v in pairs(self.ItemDirectory:GetDescendants()) do
        local item_data = v.Name == "ItemData" and Decode(v.Value)
        if not item_data then continue end
        if item_data.ItemName ~= name then continue end
        return v.Parent
    end
end

function tbl:GetItemCount(self)
	local count = 0
    for i,v in pairs(self.ItemDirectory:GetDescendants()) do
        if v.Name ~= "ItemData" then continue end
		count+=1;
	end
	tbl.data.ITEM_COUNT = count
	return count
end
function PsudoEnum(tbl)
    return tbl
end
function tbl:GetNextEmptySlot(tbl)
    for i,v in pairs(tbl) do
        if v == "" or v == "none" then
            return i
        else
            continue
        end
    end
end

function tbl:HasItem(tbl,item)
    for i,v in pairs(tbl) do
        print(i,v,item)
        if v == item then
            return true
        end
    end
end
local vowels =     "aeiouy"

function tbl:Equip(player,equip_data)
    local DATA = game.ReplicatedStorage.Bindables.GetData:Invoke(player)
    local Hotbar = DATA.Inventory.Hotbar
    local SLOT = equip_data.Slot or self:GetNextEmptySlot(Hotbar)
    if equip_data.Single then
        if self:HasItem(Hotbar,equip_data.Item) then    
            return
        end
    end
    game.ReplicatedStorage.Bindables.UpdateData:Invoke(player,"Inventory.Hotbar."..tostring(SLOT),equip_data.Item)
    local first_letter_is_vowl = string.find(vowels, equip_data.Item:sub(1,1):lower()) 
    ReplicatedStorage.Remotes.Render:FireClient(player,{Type = "notification"; Params = {
        Text = string.format( "You picked up %s %s", "a".. ((first_letter_is_vowl and "n ") or " ") , equip_data.Item );
        Lifetime = 2;
        TweenData = {
            DIRECTORY = "TextLabel";
            TWEENINFO = 2;
            PROPERTIES = {TextTransparency = 1, TextStrokeTransparency = 1}
        }
    }})
    if equip_data.PlayAnimation then
        ReplicatedStorage.Remotes.FireBindable:FireClient(player, ReplicatedStorage.Bindables.PlayViewportAnimation,ReplicatedStorage.Animations.Pickup)
    end

end

return tbl