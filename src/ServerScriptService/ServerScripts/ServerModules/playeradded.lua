return function ()
    local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
    local ProfileService = game.ReplicatedStorage.Source.Server.Modules.ProfileService
    function fill_table(literits)
        assert(type(literits)=="number", "Argument #1 NaN")
        local str = [[.]]
        return str:rep(literits-1):split([[.]])
    end

    local ProfileTemplate = {
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

    ----- Loaded Modules -----

    local ProfileService = require(game.ServerScriptService.ProfileService)

    ----- Private Variables -----

    local Players = game:GetService("Players")

    local GameProfileStore = ProfileService.GetProfileStore(
        "game-save-1",
        ProfileTemplate
    )

    local Profiles = {} -- [player] = profile

    ----- Private Functions -----
local function LoadedProfile(profile,player)
    
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
        if profile ~= nil then
            profile:Release()
        end
    end)

end