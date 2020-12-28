return setmetatable({
    {alias = {"default","Default"}; type = "Notifaction"; Positioning = "Top-center" }
},{
    __index = function(tbl,index)
        local Type = nil
        if type == index then
        
        end
        for _,v in pairs(tbl) do
            for _,k in pairs(v.alias) do
                if index == k then
                    
                end
            end
        end
    end;
})