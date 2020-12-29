local src = script.Parent.Source
local Shared = src.Shared


    local table_ = {}
    for i,v in pairs(Shared:GetChildren()) do
        table_[v.Name] = require(v)
    end
    return table_ 
