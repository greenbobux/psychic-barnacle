-- Data Handle Module
-- Username
-- January 9, 2021


                            local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")

                            local DataHandleModule = {}

                            local IsClient = RunService:IsClient()

                            local function GetPlayerFromName(name)
                                for _,player in pairs (Players:GetPlayers()) do
                                    if player.Name:lower() == name then
                                        return player
                                    end
                                end
                            end


function DataHandleModule.new(player )
    local Data = {}
    Data.Connect = Instance.new("BindableFunction")
    if IsClient then
        player = player or Players.LocalPlayer
        -- client
    else
        -- server

    end
    
    local MODULE = {}
        MODULE.DataChanged = {}
        function MODULE.DataChanged.Connect(self,FUNCTION)
            
        end
    return MODULE
end

return DataHandleModule