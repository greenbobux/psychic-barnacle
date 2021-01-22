-- Item Click
-- Username
-- January 15, 2021



local ItemClick = {}
local CollectionService = game:GetService("CollectionService")
local itemhandle = require(game.ReplicatedStorage.item_handler)

local CLICK = CollectionService:GetTagged("item_click")
for i,click_detect in pairs(CLICK) do
    
    click_detect.MouseClick:Connect(function(player)
        itemhandle:Equip(player,{ Item = click_detect.ItemName.Value; Single = true; PlayAnimation = true;})
    end)
end
return ItemClick