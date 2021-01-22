return function ()
    local ReplicaService = require(game.ServerScriptService.ReplicaService)
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
    local ProfileService = game.ReplicatedStorage.Source.Server.Modules.ProfileService
    local Replica = require(game.ServerScriptService.ReplicaService)
    local HttpService = game:GetService("HttpService")
    function ParseDirectory(str)
        local tbl = string.split(str,".")
        local CurrentDirectory = ReplicatedStorage.Remotes
        for i,v in pairs(tbl) do
            local Canadate = CurrentDirectory[v]
            if Canadate then
                CurrentDirectory = Canadate
            end
            if i == #tbl then
                return CurrentDirectory
            end
        end
    end


    
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
            [45] = "hi";
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
    local HttpService = game:GetService("HttpService")
    ----- Private Variables -----

    local Players = game:GetService("Players")

    local GameProfileStore = ProfileService.GetProfileStore(
        "game-save-4",
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

        ----- Private Functions -----
    
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
                print(profile.Data)
                
                game.ReplicatedStorage.Remotes.DataReplicator:FireClient(player,profile.Data)
                setmetatable(profile.Data,{__newindex = function(tbl,k,v)
                    tbl[k] = v 

                end})
                
                

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
    local function Wait()
        return RunService.Heartbeat:Wait()
    end
        Players.PlayerAdded:Connect(PlayerAdded)

        Players.PlayerRemoving:Connect(function(player)
            local profile = Profiles[player]
            if profile ~= nil then
                profile:Release()
            end
        end)
       
        function ReplicateUpdate(player,data)
            game.ReplicatedStorage.Remotes.DataReplicator:FireClient(player,data)
        end
        
        ReplicatedStorage.Bindables.GetData.OnInvoke = function(player)
            return Profiles[player].Data
        end
        ReplicatedStorage.Bindables.SetData.OnInvoke = function(player,data)
            Profiles[player].Data = data
            ReplicateUpdate(player,Profiles[player].Data)
        end 
        ReplicatedStorage.Bindables.UpdateData.OnInvoke = function(player,directory,data)
            
            local profile = Profiles[player]
            
                local current = profile.Data
            
                local key
            local number_index = 0
            local string_index
            print(directory.." <- directory ezezez")
            directory = string.split(directory,".")
            for i,v in pairs(directory) do
                local check = type(tonumber(v)) ~= nil and tonumber(v) or v
                if not current[check] then continue end
                if i ~= # directory then
                    
                    current = current[v]
                else

                    
                    print(check)
                    
                    string_index = check
                end
            end
            current[string_index] = data
            local DATA = {}
                for i,v in pairs(profile.Data) do
                    DATA[i] = v
                end
            game.ReplicatedStorage.Remotes.DataReplicator:FireClient(player,DATA)
            
        end
        local data_request = {}
        ReplicatedStorage.Remotes.irllywantbobuxforchristmas.OnServerInvoke = function(player)
                local Profile
                player = game.Players:FindFirstChild(player.Name)
                repeat
                    Wait()
                until Profiles[player]
                
                Profile = Profiles[player]
                
            return Profile.Data
        end
        
end

    