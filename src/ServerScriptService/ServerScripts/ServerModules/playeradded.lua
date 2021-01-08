return function ()
    local ReplicaService = require(game.ServerScriptService.ReplicaService)
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
    local ProfileService = game.ReplicatedStorage.Source.Server.Modules.ProfileService
    local HttpService = game:GetService("HttpService")
    function fill_table(literits)
        assert(type(literits)=="number", "Argument #1 NaN")
        local str = [[.]]
        return str:rep(literits-1):split([[.]])
    end
    local table7 = fill_table(7)
    local table21 = fill_table(20)
    print(table7,table21)
    local ProfileTemplate = {
        Burritos = 10;
		Inventory = {
			Hotbar =  {
                 "";
                 "";
                 "";
                 "";
                 "";
                 "";
                 "";
                };
			Inventory = {
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               "";
               };
		};
    }

    ----- Loaded Modules -----

    local ProfileService = require(game.ServerScriptService.ProfileService)

    ----- Private Variables -----

    local Players = game:GetService("Players")

    local GameProfileStore = ProfileService.GetProfileStore(
        "game-save-1",
        ProfileTemplate
    )

    local Profiles = {} -- [player] = profile
    --[[
        {
        Burritos = 10;
		Inventory = {
			Hotbar = {
            fill_table(7)
			};
			Inventory = {
                fill_table(21)
            };
		};
    }

    ]]

    function TableToData(table,player)
    local HttpService = game:GetService("HttpService")
    local function Encode(data)
        return HttpService:JSONEncode(data)
    end
    
    local folder = Instance.new("Folder")
    local function RecursiveSearch(aTable,Parent)
        for key, value in pairs(aTable) do --unordered search
            if(type(value) == "table") then
                local folder2 = Instance.new("Folder")
                folder2.Name = key
                folder2.Parent = Parent
                RecursiveSearch(value,folder2)
            else
                local bools = {StringValue=nil,NumberValue=nil,BoolValue=nil}
                local v_t = type(value)
                bools.StringValue = v_t == "string" or v_t == "table"
                bools.NumberValue = v_t == "number"
                bools.BoolValue = v_t == "boolean"
                for i,v in pairs(bools) do

                    if v then
                        local valuee = Instance.new(i)
                        valuee.Parent = Parent
                        valuee.Name = key
                        valuee.Value = value
                        valuee:GetPropertyChangedSignal("Value"):Connect(function()
                            local NewValue = valuee.Value
                            aTable[key] = NewValue
                        end)
                    end
                end

            end
        end
    end
    
    local tbl_ = {}
    tbl_ = table.Data
    for i,v in pairs(tbl_) do
       
        local v_t = type(v)

        local parse = ""
        if v_t == "string" or v_t == "table" then
            parse = "String"
        elseif v_t == "number" then
            parse = "Number"
        elseif v_t == "boolean" then
            parse = "Bool"
        end
        parse = Instance.new(parse.."Value")
        parse.Parent = folder
        parse.Name = i
        parse.Value = type(v) == "table" and HttpService:JSONEncode(v) or v
        parse:GetPropertyChangedSignal("Value"):Connect(function()
            local NewValue = parse.Value
            print("New Value".. NewValue)
            table[i] = NewValue
        end)
    end

    return tbl_,folder
    end
    ----- Private Functions -----
    local function LoadedProfile(profile,player)
        local tbl_experimental,folder = TableToData(profile,player)
        folder.Parent = player
        folder.Name = "Data"
    end
    local kickmsg = "This means you've logged in on two accounts."
    local function PlayerAdded(player)
        local profile = GameProfileStore:LoadProfileAsync(
            "Player_" .. player.UserId,
            "ForceLoad"
        )
        if profile ~= nil then
            profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
            profile:ListenToRelease(function()
                Profiles[player] = nil
                -- The profile could've been loaded on another Roblox server:
                player:Kick(kickmsg)
            end)
            if player:IsDescendantOf(Players) == true then
                Profiles[player] = profile
                LoadedProfile(profile,player)
            else
                -- Player left before the profile loaded:
                profile:Release()
            end
        else
            -- The profile couldn't be loaded possibly due to other
            --   Roblox servers trying to load this profile at the same time:
            player:Kick(kickmsg) 
        end
    end

    ----- Initialize -----

    -- In case Players have joined the server earlier than this script ran:
    for _, player in ipairs(Players:GetPlayers()) do
        coroutine.wrap(PlayerAdded)(player)
    end

    ----- Connections -----

    Players.PlayerAdded:Connect(PlayerAdded)

    Players.PlayerRemoving:Connect(function(player)
        local profile = Profiles[player]
        local folder = game.ServerStorage.ProfileHandler__.profiles:FindFirstChild(player)
        if folder then
            folder:Destroy()
        end
        if profile ~= nil then
            profile:Release()
        end
    end)

end