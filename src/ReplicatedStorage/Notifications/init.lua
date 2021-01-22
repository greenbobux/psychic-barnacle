-- Notifications
-- green/devtychi
-- January 16, 2021



local Notifications = {}
local ALIASES_MODULE = require(script.aliases)

Notifications.Types = {
    POSITIONING = {
        TopCenter = {Positioning = UDim2.new(0.427, 0,0.049, 0); data = {

        }};
        TopBottom = {Positioning = UDim2.new(0.427, 0,0.98, 0);  data = {
    
        }};
    };
}
function sro(tbl)
    return setmetatable(tbl,{__newindex = function()
        return "read only"
    end})
end
Notifications.UI = {
    UI_TYPES = {

    };
    types =  {
        notification_header = game.ReplicatedStorage.assets.ui.Notifications.notification
    }
}
function Notifications.UI.types:New(type)
    return Notifications.UI.types[type]
end
function Notifications.UI:CreateNewUI(type)
    return {type:Clone()}
end
setmetatable(Notifications.UI.types,{
    __index = function(Table,index)
        local value = rawget(Table,index)
        local IndexValid = false
        if value then
            IndexValid = true
        else
            return nil
        end
        
        return setmetatable({},{__index = function(tbl,index)
            if value[index] then
                return value[index]
            else
                return tbl[index]
            end
        end})

    end
})
-- for i,v in pairs(Notifications.Types.POSITIONING) do
--     local type_ = Notifications.Types.POSITIONING[v]
--     v.Name = i
--     if type_ then
--         local alias = ALIASES_MODULE[v]
--         setmetatable(type_,{__index = function(tbl,k)
--             if alias then
--                 if alias.alias[k] then
--                     return tbl[k]
--                 end
--             else
--                 return tbl[k]
--             end
--         end})
--     end
-- end
function Notifications.Types:New(type)
    local data = Notifications.Types.POSITIONING[type]
    
    return data
end
function Notifications:Create(TYPE,UI)
    
end
return Notifications