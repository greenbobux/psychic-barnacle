local ReplicatedStorage,ServerStorage,Players,TweenService,RunService,Json = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService"),function(str,type) local HttpService = game:GetService("HttpService") return HttpService["JSON"..type](str) end
local tbl  = {}
function tbl.new(stringvalue)
    function ds()
        return Json(stringvalue.Value,"Decode")
    end

    function ev(data)
        stringvalue.Value = Json(data,"Encode")
    end

    local wrap = {}
        setmetatable(wrap,{
            __index = function(tbl,k)
                return ds()[k]
            end;
            
            __newindex = function(tbl,k,v)
                local new = ds()

                new[k] = v

                ev(new)
            end
        })
    return wrap
end
return tbl