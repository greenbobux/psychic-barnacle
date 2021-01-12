    -- variables
                local main = {  info    =   {  };   Cache = nil}
                local info = setmetatable({},{__index = main.info, __newindex = main.info})
                local ReplicatedStorage,ServerStorage,Players,TweenService,RunService = game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Players"),game:GetService("TweenService"),game:GetService("RunService")

                local Events = {}

        -- functions
                        function main.init(self)
                            
                            
                            
                          

                                    ReplicaController.ReplicaOfClassCreated("DataReplica", function(replica)
                                        print("TestReplica received! Value:", replica.Data.Value)

                                        replica:ListenToChange("Data", function(new_value)
                                            print("Value changed:", new_value)
                                        end)
                                        replica.RequestData()
                                    end)

                               
                            
                            self.info.init = true
                            
                            
                        end

                        function main.DataReplicated()
                                    local event_bind = Instance.new("BindableFunction")

                                    local event = {}

                                    table.insert(Events,event_bind)

                                    function event.Connect(self,FUNCTION)
                                        event_bind.OnInvoke = function(value)
                                            FUNCTION(value)
                                        end
                                    end

                                    function event.Wait(self)
                                        local value
                                            self.Connect(function(value)
                                                value = value
                                            end)
                                        
                                        return value
                                    end
                                    
                                    table.insert(Events,event)
                            return event
                        end



return main