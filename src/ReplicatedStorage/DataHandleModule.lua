
-- Data Handle Module

-- Username

-- January 9, 2021





local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")
                            


                            local DataHandleModule = {Client = {

                                Cache = nil

                            }}

                        

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

    local Connections = {}

    Data.connect_bind = Instance.new("BindableFunction")

    Data.connect_bind.OnInvoke = function(args)

        for i,v in pairs(Connections) do
            coroutine.wrap(v)(args)
        
        end
    -- 
    end     

    if IsClient then

        player = player or Players.LocalPlayer


        -- ReplicatedStorage.Remotes.irllywantbobuxforchristmas:InvokeServer()
        ReplicatedStorage.Remotes.DataReplicator.OnClientEvent:Connect(function(data)
            data = ReplicatedStorage.Remotes.irllywantbobuxforchristmas:InvokeServer()
            DataHandleModule.Client.Cache = data
            
            Data.connect_bind:Invoke(data)

            

        end)

        
        -- client

    else

        -- server
        


    end

    

    local MODULE = {}

    MODULE.DataChanged = {}

    MODULE.Cache = {}
        function MODULE.DataChanged.Connect(self,FUNCTION)

            table.insert(Connections,FUNCTION)

        end

        return MODULE

end



return DataHandleModule