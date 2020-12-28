return setmetatable({
    {alias = {"default","Default"}; type = "Notifaction"; Positioning = "Top-center" }
},{
    __index = function(tbl,index)
        local Type = nil
        if tbl.type == index then
            Type = tbl.Type
        end
        for _,v in pairs(tbl) do
            for _,k in pairs(v.alias) do
                if index == k then
                    Type = tbl.Type
                end
            end
        end
    end;
})